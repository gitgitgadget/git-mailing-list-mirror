From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/4] tests: use test_cmp instead of piping to diff(1)
Date: Sun, 14 Nov 2010 11:41:33 -0600
Message-ID: <20101114174133.GD26459@burratino>
References: <1289745857-16704-1-git-send-email-avarab@gmail.com>
 <1289745857-16704-4-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 14 18:42:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHgak-00055o-U5
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 18:42:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756543Ab0KNRmI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Nov 2010 12:42:08 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:54742 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756434Ab0KNRmH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Nov 2010 12:42:07 -0500
Received: by gxk23 with SMTP id 23so2609634gxk.19
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 09:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=KdAdDZQrLkIGHiDWai5Xbio/bJfCw2Yupq1mU9zljTk=;
        b=NzD90asP9kxCva1fiVqozGKRWHoeC/4KEq/J00Jm55NXrbkRzkNxtIbdMjrZLF0pVd
         wb9IzDqbI11ONfMiCruoTLQ1Uhir3ium0Vop8pvaQDIY0J1bidJmAt7ryn6DhnKGpzsm
         8UQJ+wUv/shokgJF+1JFslfwgzV0yB88jO4IA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Lfm6bgd5WzTho2LJbMxYUeosQZtzf9nChoMehbjUGjAGNzoGQ6WwQOifEx8Ba4hEaX
         MyVSh5DlQb07SIkjrt1At+LBGkcFqeKD1rt+x3v+DU2+Yf2kTX9oQ3yCf14O7W4y+Bmv
         RKvaggBJxf6nlw+rWtpivru0qpiCypqWLMySQ=
Received: by 10.150.189.19 with SMTP id m19mr7829896ybf.347.1289756526887;
        Sun, 14 Nov 2010 09:42:06 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id g6sm2732245anh.31.2010.11.14.09.42.04
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Nov 2010 09:42:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1289745857-16704-4-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161424>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> --- a/t/t4041-diff-submodule-option.sh
> +++ b/t/t4041-diff-submodule-option.sh
> @@ -37,9 +37,10 @@ head1=3D$(add_file sm1 foo1 foo2)
>  test_expect_success 'added submodule' "
>  	git add sm1 &&
>  	git diff-index -p --submodule=3Dlog HEAD >actual &&
> -	diff actual - <<-EOF
> +	cat >expected <<-EOF &&
>  Submodule sm1 0000000...$head1 (new submodule)
>  EOF
> +	test_cmp expected actual
>  "

Nice.  Reminds me of
http://thread.gmane.org/gmane.comp.version-control.git/160168/focus=3D1=
60222
(use of "cmp - foo.expect" in git svn tests); anyone want to take a
stab at fixing that, too?

> --- a/t/t7401-submodule-summary.sh
> +++ b/t/t7401-submodule-summary.sh
[...]
>  test_expect_success '--for-status' "
>      git submodule summary --for-status HEAD^ >actual &&
> -    test_cmp actual - <<EOF
> +	test_cmp actual - <<EOF

I think this tab should be spaces?  Also, shouldn't this be

	cat >expect <<EOF &&
	...
	EOF
	test_cmp expect actual

to match the others?  There are a few similar cases in the patch.

I assume you've checked the patched tests still pass.  So with the exce=
ption
just mentioned,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
