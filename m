From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] diff: "S_IFREG | 0644" to "(S_IFREG | 0644)" to avoid
 warning
Date: Mon, 4 Oct 2010 04:35:19 -0500
Message-ID: <20101004093519.GN24884@burratino>
References: <1286184071-28457-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Dan McMahill <dmcmahill@NetBSD.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 11:38:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2hVJ-0004OG-AK
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 11:38:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754526Ab0JDJie convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 05:38:34 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64461 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754141Ab0JDJid convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 05:38:33 -0400
Received: by iwn5 with SMTP id 5so6698011iwn.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 02:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=kRBtTQ6jizrZVc5MZm8E58V353CVLShCWD560U3bT/g=;
        b=qs7aNKUsZE8PDmbpgOHifNjatdb1pJO0AxKNKuCD9SEqo5NTaw2+7Wez55KfOvvKgZ
         SnJIAUIOBncEh2NNwH+9zi62C9+SycbEW7C0plOsvfcw7cF7wQLWQ02+zF4o38qqwTak
         NjQ452WtGzmKoi5y0FhKB1TdTHg35E84KEtto=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=AEL1osfZDBmx0FhSZ2fCUBmPjF//+foxP7vIoaJxpPbivf7n9ul9RINd4IlzoacI4W
         vrak8SQZHv5xX3uHd4A9JJfTeVp/rsjW7nT6/WjagKV/01tsSokT4PV/j9WCC3Jaj8zw
         SI1kQ8rQQpCaKsxxp1DtlAfU63haGhv/q+xag=
Received: by 10.231.156.65 with SMTP id v1mr9882012ibw.107.1286185113371;
        Mon, 04 Oct 2010 02:38:33 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id d13sm2889134ibb.20.2010.10.04.02.38.32
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 02:38:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286184071-28457-1-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158019>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> -	unsigned mode =3D canon_mode(S_IFREG | 0644);
> +	unsigned mode =3D canon_mode((S_IFREG | 0644));

Just curious:

#define canon_mode(mode) \
        (S_ISREG(mode) ? (S_IFREG | ce_permissions(mode)) : \
        S_ISLNK(mode) ? S_IFLNK : S_ISDIR(mode) ? S_IFDIR : S_IFGITLINK=
)

#define ce_permissions(mode) (((mode) & 0100) ? 0755 : 0644)

Since S_ISREG et al are macros, typically they would put their
argument in parentheses in the definition.  How are they defined
in NetBSD sys/stat.h?  What is canon_mode(S_IFREG | 0644) being
misinterpreted to mean?
