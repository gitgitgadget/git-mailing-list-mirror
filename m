From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/48] Handling more corner cases in merge-recursive.c
Date: Sat, 11 Jun 2011 23:18:17 -0700
Message-ID: <7vzklnshcm.fsf@alter.siamese.dyndns.org>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
 <7vipsctez0.fsf@alter.siamese.dyndns.org>
 <BANLkTimd0O70e7KhT-G5quxQhF_Nwc30Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 12 08:18:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVe0N-0000Fx-1a
	for gcvg-git-2@lo.gmane.org; Sun, 12 Jun 2011 08:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601Ab1FLGS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jun 2011 02:18:28 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60315 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026Ab1FLGS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2011 02:18:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 60708585E;
	Sun, 12 Jun 2011 02:20:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tVAUGm+lgFsYsO3sn0TVcYGWqcM=; b=ULeP8K
	QD9Reb7/qylcQmpk3BKns17jvbK69SYdSFPRLGHDzMITciXwlz/67DTEd9tuDdhJ
	FN+7XwlOyaqmpFHjCKTYctomID1QMcMV3LRv+nkCw4BBH0qAUtDR/7kcYK17fdyD
	G7Dm3PkdxT76sJ61kehZtkPnVXOfC8HbNF/qU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kuQRSnyz9GOyhy4x9jjVjQz3BTWFEnH9
	/lWV0hPrMFEm8HS8sHs0+lY6ZdkZxGoSaXxvv7qlhNUWn+73LvLU6rfNcRiJDWXi
	NgwtDj/7wTE8dgOOTzkZ+ukcp6meFJSeVm4b1eXR/CEZxkfBAkLb6+bWaq3dOlWc
	cn3+c8vJIjw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 14DB0585D;
	Sun, 12 Jun 2011 02:20:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F16FF585C; Sun, 12 Jun 2011
 02:20:28 -0400 (EDT)
In-Reply-To: <BANLkTimd0O70e7KhT-G5quxQhF_Nwc30Hg@mail.gmail.com> (Elijah
 Newren's message of "Sat, 11 Jun 2011 23:42:41 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 13E745BE-94BC-11E0-B020-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175652>

Elijah Newren <newren@gmail.com> writes:

> It does sound potentially expensive, though, and might mean a lot
> more work in merge-recursive to handle that extra information.  Is that a
> path we want to take at some point?

Probably you can start with backend specific option (e.g. -Xbreak=yes) to
experiment. We made recursive the default not because it deals with
renames (in a broken way) but primarily because it handles criss-cross
better; at some point we might also want to add another backend specific
option (e.g. -Xrename=off) to allow the users to keep the "recursive"
aspect of the strategy while declining a more expensive (and brittle)
rename handling to take effect.

My gut feeling is that -Xbreak=yes, once the code does work well enough,
would have to become the default. It would make the default mode of merge
possibly quite expensive but it is Ok as long as we give projects with
simple/clean history an easy way to use either "recursive -Xrename=off" or
even "resolve" to avoid cost that is unnecessary to handle their needs.
