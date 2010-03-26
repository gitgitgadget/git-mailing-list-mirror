From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] builtins: do not commit pager choice early
Date: Fri, 26 Mar 2010 15:03:47 -0500
Message-ID: <20100326200347.GA11395@progeny.tock>
References: <1269524295-24569-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 26 21:03:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvFkr-00032o-0Y
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 21:03:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902Ab0CZUDf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Mar 2010 16:03:35 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:61156 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752320Ab0CZUDe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 16:03:34 -0400
Received: by pwi5 with SMTP id 5so5390466pwi.19
        for <git@vger.kernel.org>; Fri, 26 Mar 2010 13:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ZCPngHv4qqc56nF/BTYdp819P0d/zPnJfiD3UONUSw8=;
        b=DNgyv50peQUqTINEKivIO8lMkHxuVMqdHVGC2v9aqvvchD4yv/MtdTbdBKnajvPty3
         6QFPjzJM2RVpml3TjxnFKqh6TpA5SFqLpisqOr12lvMgGs2TOQ6tCu3k9UixrKueM1Vs
         DkNakhWwRn31jyBKVPgAc6P06BInQndpba7NM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=loiOVI9ndnym4mdkh1oi4pNO2rShMzv6lR0chEmd6ItoJ23zA0Ihq+TScqE/W16Wi6
         3mITk7MpjNaei4SwyW6OX9cLflYM6eHDiKHVfG3k+tzOtmLsI+OIP9LZ8R10RoSaFeLo
         rXcxeQLGNFbGK9WnXLoDjdsjw7O7W0j9faE54=
Received: by 10.141.13.6 with SMTP id q6mr1521618rvi.146.1269633813865;
        Fri, 26 Mar 2010 13:03:33 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm1090775iwn.13.2010.03.26.13.03.32
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 26 Mar 2010 13:03:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1269524295-24569-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143275>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> Committing pager choice may require setting up the pager, which
> will need access to repository.
[...]
> Signed-off-by: Duy Nguyen <pclouds@gmail.com>

Tested-by: Jonathan Nieder <jrnieder@gmail.com>

Without this patch, I get

| * expecting success:=20
|         test_terminal git --paginate rev-list HEAD &&
|         test -e paginated.out
|=20
| fatal: internal error: access to .git/config without repo setup
| * FAIL 7: git --paginate rev-list uses a pager

and with it, t7006 passes again.  I assume on your system that
test was being skipped when running tests without -v (confusing,
yes) because that test needs a tty but IO::Pty from CPAN is not
present.

> There are several possible code path after
> handle_options()/commit_pager_choice() is called:
>=20
> 1. list_common_cmds_help()
> 2. run_argv()
> 3. help_unknown_cmd()
>=20
> Case 2. will have commit_pager_choice() called inside run_builtin() i=
f
> a command is found. Case 1. and 3. won't need a pager, it's short
> printout and should be fitted within a screen. So, removing
> commit_pager_choice() call after handle_options() is safe.

Makes sense.

Thanks,
Jonathan
