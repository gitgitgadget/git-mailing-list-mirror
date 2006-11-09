X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: protect blob and diff output lines from controls.
Date: Thu, 9 Nov 2006 11:41:41 +0100
Message-ID: <200611091141.42205.jnareb@gmail.com>
References: <7vpsbxqzre.fsf@assigned-by-dhcp.cox.net> <200611091102.56565.jnareb@gmail.com> <7v8xiklxh1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 9 Nov 2006 10:41:11 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=MSEidwNfB4+WfLftHx5mToJ/m6WQCSN4evKMlS9OrZdFzCp2Ylx/Lm/gi5MxtDdlx5b6k+e44RFYMP9oDIuYNX6a9/MBb1Qt0dMoT3ta6fAVZlIa3uErJpv0UbBJJt3zeCwi1i+tlPIHtw8NSsyy5IXdvx90dgQWg8rFr8nK4Ug=
User-Agent: KMail/1.9.3
In-Reply-To: <7v8xiklxh1.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31194>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gi7L5-0006Bp-QY for gcvg-git@gmane.org; Thu, 09 Nov
 2006 11:40:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932430AbWKIKkw convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 9 Nov 2006 05:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWKIKkw
 (ORCPT <rfc822;git-outgoing>); Thu, 9 Nov 2006 05:40:52 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:59812 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S932430AbWKIKkv
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Nov 2006 05:40:51 -0500
Received: by ug-out-1314.google.com with SMTP id m3so177037ugc for
 <git@vger.kernel.org>; Thu, 09 Nov 2006 02:40:50 -0800 (PST)
Received: by 10.67.22.7 with SMTP id z7mr1128149ugi.1163068849762; Thu, 09
 Nov 2006 02:40:49 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id o30sm662188ugd.2006.11.09.02.40.49; Thu, 09 Nov
 2006 02:40:49 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> Junio C Hamano wrote:
>>> [...] =A0There is another
>>> thing I noticed while testing it with an artifitial test that I
>>> haven't fixed, but I think you already know about it (when the
>>> commitdiff is completely empty except mode changes, we end up
>>> with unbalanced div). =A0My test's tip can be found at
>>> 'gitweb-test-funny-char' branch temporarily in the git.git
>>> repository.
>>
>> Damn. I thought I corrected this on resend...
>=20
> I think you need this, otherwise when the last filepair changes
> only metainfo you fail to close the extended header div.

True, I forgot about the situation where empty patch is _last_
in the patchset (which includes the situation when it is _only_
patch).

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 1a757cc..e54a29e 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2338,6 +2338,8 @@ sub git_patchset_body {
> =20
>  		print format_diff_line($patch_line);
>  	}
> +	print "</div>\n" if $in_header; # extended header
I would write '# class=3D"diff extended_header"' here instead.
> +
>  	print "</div>\n" if $patch_found; # class=3D"patch"
> =20
>  	print "</div>\n"; # class=3D"patchset"

Looks good. Ack.

--=20
Jakub Narebski
