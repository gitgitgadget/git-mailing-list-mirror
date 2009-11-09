From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: [PATCH 2/3] t5551-http-fetch: Work around some libcurl versions
Date: Mon, 9 Nov 2009 10:36:33 -0800
Message-ID: <905315640911091036t21321a54u4a4c20d2b2034ad7@mail.gmail.com>
References: <1257790237-30850-1-git-send-email-spearce@spearce.org> 
	<1257790237-30850-2-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Nov 09 19:37:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7Z6p-0003Uu-GK
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 19:36:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbZKISgs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Nov 2009 13:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbZKISgs
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 13:36:48 -0500
Received: from mail-pz0-f188.google.com ([209.85.222.188]:35157 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbZKISgr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Nov 2009 13:36:47 -0500
Received: by pzk26 with SMTP id 26so2275546pzk.4
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 10:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=7zvyvSAodgqGQKYCuw8S3aGGl6SYXD/iOMYEo03M1KI=;
        b=cxsGsqNg4LqKL/lA3rnmso1tS0Y4+bGtDwGR8ntDIsy/vz2XFodsS3ByQXCkjq1ptw
         9M4zzT2MUFKYMOAE6RQ8OXAh9C4a9WE64XLwToO/X7y/tUr9v9qs6+dWoxjYbYyjSZwC
         TLAiRaqY9r7NkRjDJilbtnmQ0Qm0CD+drmFMc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=myYcF9kgydjQ6AR2KGqKB+zKf2B4U4rDMbHEvs4f57Fv7oM6dkOSM5OUwqS2GclEdg
         TLPbekRxGNW4KcH5tEUK6njVCWOBh+IQYQahxYd1OrRA++0Ab2FSqTMCOmxeA0462JR3
         C+x+LvrlkIy0UYGREhBm3GjBcbMgt/ri68hXQ=
Received: by 10.142.59.11 with SMTP id h11mr658517wfa.154.1257791813174; Mon, 
	09 Nov 2009 10:36:53 -0800 (PST)
In-Reply-To: <1257790237-30850-2-git-send-email-spearce@spearce.org>
X-Google-Sender-Auth: e4453b68af371550
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132504>

On Mon, Nov 9, 2009 at 10:10 AM, Shawn O. Pearce <spearce@spearce.org> =
wrote:
> Some versions of libcurl report their output when GIT_CURL_VERBOSE
> is set differently than other versions do. =A0At least one variant
> (version unknown but likely pre-7.18.1) reports the POST payload to
> stderr, and omits the blank line after each HTTP request/response.

Yes, my curl is 7.15.5.

> @@ -56,6 +52,8 @@ test_expect_success 'clone http repository' '
> =A0 =A0 =A0 =A0sed -e "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s/Q\$//
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/^[*] /d
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /^$/d
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /^< $/d
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/^[^><]/{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s/^/> /
> @@ -64,6 +62,8 @@ test_expect_success 'clone http repository' '
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/^> User-Agent: /d
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/^> Host: /d
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s/^> Content-Length: .*/> Content-Leng=
th: xxx/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /^00..want /d
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /^00.*done/d

Almost.  This still needs a
'> '
before both of the 00 additions.  Changing this and applying 3/3 makes
the test pass for me.

Tested-with-modifications-by: Tarmigan <tarmigan+git@gmail.com>
