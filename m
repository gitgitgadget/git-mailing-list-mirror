From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] test-lib: clean up trash* directories on SIGINT
Date: Mon, 12 Jul 2010 03:56:52 -0500
Message-ID: <20100712085652.GA6837@burratino>
References: <AANLkTimnrLlprdScYDKHs_lIvFKc3K0n8U5vTzG_df2k@mail.gmail.com>
 <alpine.LFD.2.00.1007112327150.10598@xanadu.home>
 <AANLkTindliEmS2XhH8B1dUyo-v-CzpLQBqZakOaNnARW@mail.gmail.com>
 <20100712061608.GA6140@burratino>
 <AANLkTinGsIqy-rG8um1E7_zfla1KwsO2Z26JnchXaRLd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Git Mailing List <git@vger.kernel.org>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 12 10:57:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYEpc-0008OL-9D
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 10:57:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755490Ab0GLI5m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Jul 2010 04:57:42 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50037 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755134Ab0GLI5k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 04:57:40 -0400
Received: by iwn7 with SMTP id 7so4424514iwn.19
        for <git@vger.kernel.org>; Mon, 12 Jul 2010 01:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=jmd0bAeFxoRbE21F+PM2Noh8DFXJoGHTyH909l6qegc=;
        b=pKcQyjnhPeETT2oKOV8makM2m+jLoIaQu5IgMgvaWxG59fmhBZgzTQ05GtZCN7wpAY
         5/kHQrlnRiKLaNjmIzWY6SY876UmNnkxaIuqLSGz6gkgeAF2gmeZxRaLvaW7NSrsPL1o
         wdgrFz6SI0nPYcNDGi21pCxhgiUXjz/dO9RzU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=SnngQZ89NO2fUL2WX/GtkzwDCwyJ2l/EJZ9Igzk0yYPnfyC1gqfbvK3w2NWdl7BK1x
         MxN0MHyehbVudcPzKxYIvkObL0kFqGOy0vXC0cI8Z67y4ZM2N2qbPxBylZCUDs3i6eR/
         TsmmyA21/m14fozYjWcDAC5PbxBh9PeqBKMR4=
Received: by 10.231.168.208 with SMTP id v16mr9359827iby.103.1278925058376;
        Mon, 12 Jul 2010 01:57:38 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id r3sm18723952ibk.13.2010.07.12.01.57.37
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 12 Jul 2010 01:57:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinGsIqy-rG8um1E7_zfla1KwsO2Z26JnchXaRLd@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150802>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Mon, Jul 12, 2010 at 06:16, Jonathan Nieder <jrnieder@gmail.com> w=
rote:

>> So what should I do after noticing a heisenbug?
>
> Run the test again with --debug.

Sorry, I wasn=E2=80=99t clear.  The sequence I was imagining (and have
enountered) is:

 $ make test
 [...]
 not ok - 35 something that really should have been okay
 ... more text streams by ...

-- wait, what?  I=E2=80=99ve never seen that fail before.  ^C

If I catch it early enough, I can inspect the trash directory and
figure out what happened.  Some bugs are hard to reproduce (and it
avoids waiting for tests to run again).  But I can use ^Z instead.

> If I keep doing that (along with --jobs 20 and --shuffle) I'll
> eventually pile up ~200 MB of trash. That'll exceed the limits of my
> ramdisk and I'll have to grudgingly do rm -rf trash* again.

Given this rationale, I don=E2=80=99t personally mind the change (thoug=
h it
is still not clear why not to run =E2=80=9Cmake clean=E2=80=9D from t/ =
between runs
instead).

I would be more worried if you were proposing making the --immediate
option remove the trash directory, too.  I often use that option with
the express intent of populating a test repository which is no more
temporary than the .o files and copies of binaries in the build tree
are.

Thanks for the explanation,
Jonathan
