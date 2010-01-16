From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v3] Add push --set-upstream
Date: Sat, 16 Jan 2010 20:35:57 +0800
Message-ID: <20100116203557.95340c00.rctay89@gmail.com>
References: <1263633827-23720-1-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Sat Jan 16 13:36:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NW7t4-0005kn-Vr
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 13:36:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533Ab0APMgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 07:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456Ab0APMgN
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 07:36:13 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:42408 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462Ab0APMgK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 07:36:10 -0500
Received: by yxe17 with SMTP id 17so1684134yxe.33
        for <git@vger.kernel.org>; Sat, 16 Jan 2010 04:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=yhhAxtRo+hv/jSzh3JW0KJCP1ftsQBGIHZZv6o/6TGQ=;
        b=AJmkAUNcd0J7s2s5f/MlalmboWa07Abjwu6YFEnmS782EGS+B+Wb4hdIE4R3X0o9EW
         hzy8yQQqaprQlpo8bAzjk7KPS7vGweElSOcCXtOITg+vwEiPu1UHrcZF43Cbd9Zjhmj/
         qi8/2bAf1bVpUNrbaCJrFbIA71uRKFkmcsEmo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=aPLQuydIil+p+m+flqECj2HEM7pz0DEZWoTkkDa/14wVEqg9H55i9pNwdxSb1kUPBg
         PONj50SlOEHnP23eB9C2EEAWwFsVT3UAckUPpsCJvACbFr6ot7ONhh0j0yUBLzPtm+yD
         6TIZdiKXsRVpFjyki6X9JAysAn4BgY5vycwIQ=
Received: by 10.90.183.7 with SMTP id g7mr3568452agf.42.1263645368071;
        Sat, 16 Jan 2010 04:36:08 -0800 (PST)
Received: from your-cukc5e3z5n (cm154.zeta152.maxonline.com.sg [116.87.152.154])
        by mx.google.com with ESMTPS id 16sm1562459gxk.15.2010.01.16.04.36.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 16 Jan 2010 04:36:07 -0800 (PST)
In-Reply-To: <1263633827-23720-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137227>

Hi,

On Sat, 16 Jan 2010 11:23:47 +0200
Ilari Liusvaara <ilari.liusvaara@elisanet.fi> wrote:

> [snip]
> @@ -218,6 +218,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>  		OPT_BOOLEAN( 0 , "thin", &thin, "use thin pack"),
>  		OPT_STRING( 0 , "receive-pack", &receivepack, "receive-pack", "receive pack program"),
>  		OPT_STRING( 0 , "exec", &receivepack, "receive-pack", "receive pack program"),
> +		OPT_BIT('u', "set-upstream", &flags, "Set upstream for git pull", TRANSPORT_PUSH_SET_UPSTREAM),

This line exceeds 80 characters.

Also, I think you should follow the case-style of the other option
descriptions and s/Set(?= upstream)/set/.

> [snip]
> +static void set_upstreams(struct transport *trans, struct ref *refs,

I would prefer if you could follow the naming convention and say
"transport" instead of truncating to "trans".

> +	int pretend)
> +{
> +	struct ref *i;
> +	for (i = refs; i; i = i->next) {

In most places, "ref" instead of "i" is used; ie.

	struct ref *ref;
	for (ref = refs; ref; ref = ref->next) {
		..
	}

> [snip]
> +		/*
> +		 * Check suitability for tracking. Must be successful /
> +		 * alreay up-to-date ref create/modify (not delete).
> +		 */

s/alreay/already/.

> [snip]
> +		/* Chase symbolic refs (mainly for HEAD). */

Did you mean "Change" here?

Regarding the checking of ref->status here:

> @@ -135,6 +136,53 @@ static void insert_packed_refs(const char *packed_refs, struct ref **list)
>  	}
>  }
>  
> [snip]
> +		if (i->status != REF_STATUS_OK &&
> +			i->status != REF_STATUS_UPTODATE)
> +			continue;

Is it possible to delegate this to push_had_errors(remote_refs)
instead? We skip setting up upstream tracking when there are errors
from pushing, so we don't have to check ref->status anymore.

(Note: this would skip setting up upstream when ref->status is 'none',
in addition to 'ok' and 'uptodate', as you have it right now. I think
this should be safe.)

@@ -1002,8 +1055,9 @@ int transport_push(struct transport *transport,
					verbose | porcelain, porcelain,
					nonfastforward);

-		if (flags & TRANSPORT_PUSH_SET_UPSTREAM)
-			set_upstreams(transport, remote_refs, pretend);
+		if (!push_had_errors(remote_refs) && 
+			(flags & TRANSPORT_PUSH_SET_UPSTREAM))
+			set_upstreams(transport, remote_refs, pretend);

		if (!(flags & TRANSPORT_PUSH_DRY_RUN)) {
			struct ref *ref;
			for (ref = remote_refs; ref; ref = ref->next)

(As a side note, if you apply this on top of 'tr/http-push-ref-status'
in 'pu', the result of push_had_errors() is saved in a variable
('err'), so you could just use it and not have to call push_had_errors
() again.)

-- 
Cheers,
Ray Chuan
