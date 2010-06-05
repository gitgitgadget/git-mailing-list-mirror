From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC v7 1/2] Add infrastructure for translating Git with
 gettext
Date: Fri, 4 Jun 2010 22:01:00 -0500
Message-ID: <20100605030059.GB2019@progeny.tock>
References: <1275704035-6552-1-git-send-email-avarab@gmail.com>
 <1275704035-6552-2-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 05 05:01:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKjdH-00075Y-Bj
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 05:01:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755687Ab0FEDBG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jun 2010 23:01:06 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:32797 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628Ab0FEDBF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 23:01:05 -0400
Received: by iwn37 with SMTP id 37so1694116iwn.19
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 20:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=c7HdO7z0eV0Yb3P6bXwebes9HRQEGnYD2rUXOtSn5KQ=;
        b=hQemedW2h7vq0OCLIp6ObLPne/83WIX4igz10GrRJUXqWpDDElKhSssJfTtKkh3aC6
         AFQHsohQitrBKSjVwugT9rFDSHPZOpvoqZwq3hIqi3CW9QIYKsCxMjpcJl4wT+tuLavR
         nqo6jZXV15vEwsAjJ4TIA1U0IfGTr0aGB6VGw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ZcoehKoB75wNTD9VmSSI5dim8a6ckYPK+ehDtZowzcErZEKMj+nOYxejKGRCHH51Ii
         B50EH9WSMvF2HcpjTurIxmbXmhSqk7w0b5JRb4Ei6V+UeaLHTrs2IWxVb/mMInR5Eu8e
         Z9rd1QJV0+JvVDKKzgYiN90iz//Odi8TAj57A=
Received: by 10.231.204.199 with SMTP id fn7mr1709653ibb.132.1275706864868;
        Fri, 04 Jun 2010 20:01:04 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id f1sm8229999ibg.21.2010.06.04.20.01.03
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 04 Jun 2010 20:01:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1275704035-6552-2-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148452>

=C6var Arnfj=F6r=F0 Bjarmason wrote:

> diff --git a/gettext.c b/gettext.c
> new file mode 100644
> index 0000000..22cdcc1
> --- /dev/null
> +++ b/gettext.c
> @@ -0,0 +1,25 @@
> +#ifdef NO_GETTEXT
> +void git_setup_gettext(void) {}
> +#else
> +#include "exec_cmd.h"
> +#include <libintl.h>
> +#include <stdlib.h>
> +
> +void git_setup_gettext(void) {
[...]

Could this conditional be taken care of by gettext.h and the Makefile
and avoid complicating the main source file?  i.e., something like

 #ifdef NO_GETTEXT
 static inline void git_setup_gettext(void) {}
 #endif

and

 ifndef NO_GETTEXT
 LIB_OBJS +=3D gettext.o
 endif
