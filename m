From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH w/signoff] pre-push.sample: Remove unwanted `IFS=' '`.
Date: Sun, 21 Dec 2014 10:50:33 -0800
Message-ID: <xmqqtx0obzwm.fsf@gitster.dls.corp.google.com>
References: <1419185665-19988-1-git-send-email-gjthill@gmail.com>
	<1419186337-20348-1-git-send-email-gjthill@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Aaron Schrab <aaron@schrab.com>
To: Jim Hill <gjthill@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 21 19:50:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y2laV-0007fh-KD
	for gcvg-git-2@plane.gmane.org; Sun, 21 Dec 2014 19:50:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753659AbaLUSuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2014 13:50:37 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62886 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751521AbaLUSuf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2014 13:50:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C71A264C3;
	Sun, 21 Dec 2014 13:50:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hBsu31PnBdSLKD+/nx01ehSeUUE=; b=uolTiI
	6RsPlnTlznZF+0J1+7roFj0Jo+HhEGdyxHQT7uAp+nR8L5w/CIVgQbUnkDzhrn3l
	bRrYlAWkHnFQVX6anVgYeco44q/TnewPI3nRxe73kaVLCReVOcePTzXitVDrcCJB
	LxQKWG/xvlGR54ISukxi5T17HXsK0u39OOAp4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PM2zIAP1w+8lkVLOvh2mh37QQbK0SG4M
	Ook4Ylm7mO9+mlbRqOI90HPz1qNebReYpGi7coV3Ker6hO0Z9eKsvd3R+pOzZZx+
	kII7m79ieAWb3+qx0riJHzcDpKeWI/HGae9vHbxoKLcwdgVJTjBYaYl8CIW5f8Q8
	KiMb0+Qe5tQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 33B4F264C2;
	Sun, 21 Dec 2014 13:50:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B0DD9264C1;
	Sun, 21 Dec 2014 13:50:34 -0500 (EST)
In-Reply-To: <1419186337-20348-1-git-send-email-gjthill@gmail.com> (Jim Hill's
	message of "Sun, 21 Dec 2014 10:25:37 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3F187CAC-8942-11E4-BFA7-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261618>

Jim Hill <gjthill@gmail.com> writes:

> Signed-off-by: Jim Hill <gjthill@gmail.com>
> ---

Please clarify "unwanted" in the proposed commit log message.

It looks to me that the assignment very much deliberate.  We know
refnames and 40-hex object names do not contain SP, and the hook is
fed (quoting from Documentation/githooks.txt) like this:

    Information about what is to be pushed is provided on the hook's standard
    input with lines of the form:

      <local ref> SP <local sha1> SP <remote ref> SP <remote sha1> LF

so setting IFS to SP alone smells as an attempt to ensure that the
"read" in each loop iteration would split at SP and nothing else;
Aaron Schrab CC'ed who did the original in 87c86dd1 (Add sample
pre-push hook script, 2013-01-13).

Also you would notice by reading "git shortlog" of our history that
s/Remove/remove/ on the subject line would avoid this entry stand out
among others unnecessarily, but that is minor.

>  templates/hooks--pre-push.sample | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/templates/hooks--pre-push.sample b/templates/hooks--pre-push.sample
> index 69e3c67..6187dbf 100755
> --- a/templates/hooks--pre-push.sample
> +++ b/templates/hooks--pre-push.sample
> @@ -24,7 +24,6 @@ url="$2"
>  
>  z40=0000000000000000000000000000000000000000
>  
> -IFS=' '
>  while read local_ref local_sha remote_ref remote_sha
>  do
>  	if [ "$local_sha" = $z40 ]
