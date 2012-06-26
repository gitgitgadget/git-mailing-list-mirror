From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git submodule vs GIT_WORK_TREE
Date: Tue, 26 Jun 2012 09:07:59 -0700
Message-ID: <7vobo6cazk.fsf@alter.siamese.dyndns.org>
References: <CAD77+gTVLsEOgWo+WDafzNOYOwSZQ2KkgBuibBXemVmGu_Fzgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 18:08:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjYJS-00020T-Ot
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 18:08:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758418Ab2FZQIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 12:08:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56038 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757594Ab2FZQIS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 12:08:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E1E692D8;
	Tue, 26 Jun 2012 12:08:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=94YQcsfKki02Mix6qwufv9SwwpE=; b=h5dXmh
	iX4HcThDx+oCOfEUGAr0k1afp1uCuKL3vbN8t6zKroJ92ktg2iCToZ7/SSjl2LZh
	1lEkRzfDuf2z+wTdg0Yb3ZZqt/gl4pDD+ie3hS6UNifrb93jnEcv2D5vsLMyiAx4
	IMFoYYV+3Ac0vueOZzTQyLNpwfT9uhQXS+E4A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p7m9HaB7cluXCw/3aOJ4FDhVZoyNWGMh
	ICVop529lAy/4aWlcKmSHF8DHkiNtFyo2nppVo+JSLGlq/0MqdIL9MUsKH9lsToS
	pdokYvgg0Kgm/S/aElBfZOhQ3D5lat1v0QUVXlBjW6jTnVLEhH824LltrRSPFKPb
	zOsqgD16sNg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 940A992D7;
	Tue, 26 Jun 2012 12:08:15 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5AA9792D1; Tue, 26 Jun 2012
 12:08:11 -0400 (EDT)
In-Reply-To: <CAD77+gTVLsEOgWo+WDafzNOYOwSZQ2KkgBuibBXemVmGu_Fzgw@mail.gmail.com> (Richard
 Hartmann's message of "Tue, 26 Jun 2012 14:28:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 20856AA8-BFA9-11E1-BFFA-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200659>

Richard Hartmann <richih.mailinglist@gmail.com> writes:

> As you are most likely aware, `git submodule` allows you to access a
> separate git repository in a sub-directory, e.g. $submodule, while
> $GIT_WORK_TREE forces git to operate in a specific directory. Combine
> the two and the result is less than ideal. git is forced to operate in
> $GIT_WORK_TREE while it should operate on $GIT_WORK_TREE/$submodule,
> instead.

The end user should not be asked to anything special.

When the user exports GIT_WORK_TREE to tell git that the root of the
working tree the user wants to work on resides there (which is
needed when the user exports GIT_DIR to tell git that the user wants
to work on that repository), that wish obviously applies only to
that repository.  If git decides to visit the working tree of a
different repository (e.g. a checkout of a submodule bound to the
project GIT_WORK_TREE points at), even if it is done in response to
the user action (e.g. like passing "--recurse-submodules" option),
it should adjust GIT_WORK_TREE and GIT_DIR to be appropriate for
operations in the submodule repository while doing so.  If the more
recent "recursive" behaviour forgets to do so, it simply is a bug.
