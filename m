From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git clone NonExistentLocation
Date: Thu, 17 Feb 2011 22:02:10 -0800
Message-ID: <7vd3mp6ftp.fsf@alter.siamese.dyndns.org>
References: <4D5CE3E7.5030101@atlas-elektronik.com>
 <4D5D1715.5020707@drmicha.warpmail.net>
 <4D5D1A04.4090107@atlas-elektronik.com>
 <4D5D1BCB.3010003@drmicha.warpmail.net>
 <AANLkTin3Pf4XD_gbwxPzW4uff9SbDWJdGug6jM_SHDo+@mail.gmail.com>
 <4D5D5275.5070501@drmicha.warpmail.net>
 <20110218040152.GA25466@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 18 07:02:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqJQG-0000Jt-Cb
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 07:02:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170Ab1BRGC2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 01:02:28 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51443 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249Ab1BRGC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 01:02:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 175CB213F;
	Fri, 18 Feb 2011 01:03:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jayUcT5nEXD2PGJXWnroJHShf30=; b=MqKh1T
	65WRqJpMBNhxkK86BeynjAmMkKwYtglAzjHuizRIdlV84g8lInHbBCyarbdgJUT5
	aAjcwGR9Yc1n4i5mS+yad6/mCZHLInS8rO6gfBKEsFnv2QkK16FZbIgpD/R5OVPq
	Mo7u3L0RWVFQ4x7a6EBTPbqniCDYD5PHMF+cU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cxldLYFp4J1uy8swRp2dckpM3E7GaWWS
	7jpT73U2CeN3hcqN/cnTTYncsxshEeD/IqmSg1kGH03+j7trYtCcqmdFYIAY9FCR
	WDc8+RtFo1YFBNXamb5pnmpRpZlSLbArodRR8fQrQX9S+0NqoYYjMEWTmkm8un8T
	4yPu2/v1jac=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B6C8D213B;
	Fri, 18 Feb 2011 01:03:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 75E41213A; Fri, 18 Feb 2011
 01:03:20 -0500 (EST)
In-Reply-To: <20110218040152.GA25466@sigill.intra.peff.net> (Jeff King's
 message of "Thu\, 17 Feb 2011 23\:01\:52 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CE4C96BC-3B24-11E0-9197-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167176>

Jeff King <peff@peff.net> writes:

> I think the patch below is the right fix.
> ...
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/clone.c        |    5 ++++-
>  t/t5701-clone-local.sh |   13 +++++++++++++
>  2 files changed, 17 insertions(+), 1 deletions(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 60d9a64..55785d0 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -412,8 +412,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	path = get_repo_path(repo_name, &is_bundle);
>  	if (path)
>  		repo = xstrdup(make_nonrelative_path(repo_name));
> -	else if (!strchr(repo_name, ':'))
> +	else if (!strchr(repo_name, ':')) {
> +		if (!file_exists(repo_name))
> +			die("repository '%s' does not exist", repo_name);
>  		repo = xstrdup(make_absolute_path(repo_name));
> +	}
>  	else
>  		repo = repo_name;
>  	is_local = path && !is_bundle;

Thanks, but I am confused.

The stuff goes through make_absolute_path() so we must be certain that
this has to be a local filesystem entity _if_ it is a repository.

But when will we see a file at repo_name in this new codepath?  In what
situation would get_repo_path(repo_name, &is_bundle) return NULL but the
added file_exists(repo_name) would yield true to bypess your die()?

If repo_name is a directory, or a regular file, get_repo_path() would give
us a relative path to it, no?

IOW, wouldn't the fix be more like this?  Your new test script seems to
pass with this.

diff --git a/builtin/clone.c b/builtin/clone.c
index 60d9a64..2ee1fa9 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -413,7 +413,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (path)
 		repo = xstrdup(make_nonrelative_path(repo_name));
 	else if (!strchr(repo_name, ':'))
-		repo = xstrdup(make_absolute_path(repo_name));
+		die("repository '%s' does not exist", repo_name);
 	else
 		repo = repo_name;
 	is_local = path && !is_bundle;
