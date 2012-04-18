From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/9 v13] difftool: teach difftool to handle directory
 diffs
Date: Wed, 18 Apr 2012 09:25:24 -0700
Message-ID: <7vsjg1knwr.fsf@alter.siamese.dyndns.org>
References: <1334335002-30806-1-git-send-email-tim.henigan@gmail.com>
 <CAJDDKr7Uw3Nwg4p7F2zaY8f82j3_tRf3WiiO+YSN+nA6a9wY6w@mail.gmail.com>
 <CAJDDKr78T1HNFXPPnvMUxBoJhAHP8XGdk9ZbpQCS1sZEQJfR8w@mail.gmail.com>
 <CAFoueth37aeHMorh-r2w_mwSp+uSgeF+PYbUfHNPy9-HVvL01w@mail.gmail.com>
 <CAJDDKr6djdBvUbV6qZZu75iR2UbFHt8_D0+V+K_C+-Dgx8BfVA@mail.gmail.com>
 <CAFouetjbHewYzQXZr33xGKgwk0k7D8R0XfoP7k2qAV6Nq_d+Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	ramsay@ramsay1.demon.co.uk
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 18:25:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKXhI-0000pu-Ch
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 18:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753608Ab2DRQZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 12:25:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39808 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751376Ab2DRQZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 12:25:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B3944664A;
	Wed, 18 Apr 2012 12:25:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0i48wPUWWGi+QVj13s6n6JUOu3g=; b=YlU7Ts
	/V6eDDnPEN7WLSh2Hsrc4qGdxmd6hq0zVjv+0aEJiTwxsVShuoXhhkXf6L2RIbye
	DjQ/ohqRXPnSc707EGVpibYX3WyDlauXLAvvcgh1gHsCDMjtY7ndxGfAB6DZACrx
	avHXVMEx2R3Y4HBWrc2NCQSI/Q09OHHSfpAyw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KDU0qpVO5HIq/skddmN1li7a7fVh4b+2
	o40c3n4ukwztt6tSom+BAO5NA+CXmCRi695SvtXzM34nFTF43VOV74pWZiHtD0No
	JwWjIPGqZkByniLEQBUfsd1bVYomfwqk0aPE9dR5fT3MTjoh9wEZIO8SCH9+poej
	Pasirdr42cA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB19C6649;
	Wed, 18 Apr 2012 12:25:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 40E9C6646; Wed, 18 Apr 2012
 12:25:26 -0400 (EDT)
In-Reply-To: <CAFouetjbHewYzQXZr33xGKgwk0k7D8R0XfoP7k2qAV6Nq_d+Ow@mail.gmail.com> (Tim
 Henigan's message of "Wed, 18 Apr 2012 09:13:02 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1ADD350C-8973-11E1-8120-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195873>

Tim Henigan <tim.henigan@gmail.com> writes:

> So now we must decide how to handle deal with this use case.  It seems
> there are two options:
>
> 1) Append '--no-renames' to the end of the 'git diff --raw' argument
> list.  This will override any '-C' or '-M' settings.  This is a simple
> solution, but it loses some information about copies and renames.

Or not use Porcelain "git diff", but use the plumbing "git diff-index" or
"git diff-files" so that you won't get bitten by such end user settings.

In either case, this "feature", by feeding two entire trees to an external
program, makes it the responsibility of that external program to match up
files in these two trees, so we shouldn't be doing rename detection
ourselves at all.
