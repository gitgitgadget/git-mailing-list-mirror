From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 1/2] t/lib-http.sh: Restructure finding of default httpd 
	location
Date: Thu, 19 Nov 2009 22:14:02 -0500
Message-ID: <76718490911191914n23d067b8teb17907de9ec83d5@mail.gmail.com>
References: <1258680123-28684-1-git-send-email-tarmigan+git@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, peff@peff.net, drizzd@aon.at,
	gitster@pobox.com, spearce@spearce.org
To: Tarmigan Casebolt <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 04:14:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBJx2-0006Su-VT
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 04:14:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758248AbZKTDOB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Nov 2009 22:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758252AbZKTDOA
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 22:14:00 -0500
Received: from mail-iw0-f178.google.com ([209.85.223.178]:41413 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758243AbZKTDN4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Nov 2009 22:13:56 -0500
Received: by iwn8 with SMTP id 8so2281490iwn.33
        for <git@vger.kernel.org>; Thu, 19 Nov 2009 19:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=E43JIXqYc8Io1qA8JIZ319PN7/Qlrqikci99mpOyiuw=;
        b=lgzTRmiNAP0L+T0t8wqWv6XimuhT7OifbNBqKYyPvyAjC8wRASio+hWpnGPQe0pMSG
         13qjlHKgYJz2oacNbRRc60FyW80KYVbRi1QwD0sEt1tgWTGawot1eSP4mHbzyYvI87Jx
         aIUQSlJjNqpRF7rPsRj8Yf2wy6BZlH9uIa2vk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=O3mnOA/E6YsCspA8SSpdL6sQK2SNpGBGju3LUV8hWmpVMqfTvVY6mLslhZSb+T9H0h
         NPDmxSCdKDQj8ysTXhQeWRdDOQcVB0h/lzghFUnSpPB+PumMnzv3MUiLDEWr+aiUaxxb
         AMCsDFtD/xCt5l1SBvjedpSc4KMpE9Sqzh3OY=
Received: by 10.231.48.210 with SMTP id s18mr55638ibf.3.1258686842222; Thu, 19 
	Nov 2009 19:14:02 -0800 (PST)
In-Reply-To: <1258680123-28684-1-git-send-email-tarmigan+git@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133301>

On Thu, Nov 19, 2009 at 8:22 PM, Tarmigan Casebolt
<tarmigan+git@gmail.com> wrote:
> uname might not be the best way to determine the default location for
> httpd since different Linux distributions apparently put httpd in
> different places, so we test a couple different locations for httpd,
> and use the first one that we come across. =C2=A0We do the same for t=
he
> modules directory.

Perhaps testing the distribution and looking in the known location for
that distribution then? That said, going through a list of well known
locations should work too.

> +for DEFAULT_HTTPD_PATH in '/usr/sbin/httpd' '/usr/sbin/apache2'
> +do
> + =C2=A0 =C2=A0 =C2=A0 test -x "$DEFAULT_HTTPD_PATH" && break
> +done

Unfortunately this leaves DEFAULT_HTTPD_PATH as the last item in the
list even if the test does not pass. You can add an empty item to the
end of the list if you want to do this way.

> +for DEFAULT_HTTPD_MODULE_PATH in '/usr/libexec/apache2' \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 '/usr/lib/apache2/modules' \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 '/usr/lib64/httpd/modules' \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 '/usr/lib/httpd/modules'
> +do
> + =C2=A0 =C2=A0 =C2=A0 test -d "$DEFAULT_HTTPD_MODULE_PATH" && break
> +done

Ditto.

j.
