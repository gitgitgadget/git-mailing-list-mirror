From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: [PATCH 1/6] Add string comparison functions that respect the
 ignore_case variable.
Date: Mon, 30 Aug 2010 08:42:12 -0600
Message-ID: <4C7BC344.9020500@workspacewhiz.com>
References: <cover.1281985411.git.j6t@kdbg.org>	<4C6C01A9.4080306@workspacewhiz.com>	<AANLkTinwQqwjmeNfiUE6LiZtbBhEEFyisZXUgF9_b+2Q@mail.gmail.com>	<201008182032.40375.j6t@kdbg.org> <AANLkTimtmudtWccRS==LrO_JrPmAJ7HzA6CU0ALbDZcV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 16:42:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq5Z2-0002Ha-TY
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 16:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753884Ab0H3OmS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 10:42:18 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:37673 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753583Ab0H3OmR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 10:42:17 -0400
Received: (qmail 2876 invoked by uid 399); 30 Aug 2010 08:42:16 -0600
Received: from unknown (HELO ?192.168.1.2?) (jjensen@workspacewhiz.com@69.98.154.28)
  by hsmail.qwknetllc.com with ESMTPAM; 30 Aug 2010 08:42:16 -0600
X-Originating-IP: 69.98.154.28
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.8) Gecko/20100802 Lightning/1.0b2 Thunderbird/3.1.2
In-Reply-To: <AANLkTimtmudtWccRS==LrO_JrPmAJ7HzA6CU0ALbDZcV@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154817>

  ----- Original Message -----
=46rom: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
Date: 8/29/2010 1:39 PM
> On Wed, Aug 18, 2010 at 18:32, Johannes Sixt<j6t@kdbg.org>  wrote:
>> On Mittwoch, 18. August 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason=
 wrote:
>>> According to some further research at least FreeBSD and NetBSD have
>>> copied this GNU extension. You may find their versions easier to
>>> integrate.
>> We already have a GNU fnmatch in compat/fnmatch.
> Do you have any plan to deal with this? I currently have this
> monkeypatch to build on Solaris:
>
>      diff --git a/Makefile b/Makefile
>      index 62d526a..079fae5 100644
>      --- a/Makefile
>      +++ b/Makefile
>      @@ -863,2 +863,4 @@ endif
>       ifeq ($(uname_S),SunOS)
>      +       COMPAT_OBJS =3D compat/fnmatch/fnmatch.o
>      +       COMPAT_CFLAGS =3D -Icompat -Icompat/fnmatch
>              NEEDS_SOCKET =3D YesPlease
>
> One way to deal with it would be a new NONGNU_FNMATCH=3DUnfortunately=
Yes
> flag, or the fnmatch_icase() suggestion above which we could bundle
> and always use. But having next build on systems without GNU
> extensions would be preferrable.
I am going to deal with this, but I haven't been around.  I hope for=20
some time this week.

Short of duplicating fnmatch's code and renaming the function, I am not=
=20
sure how to make this play nice on all systems.  You added COMPAT_OBJS=20
above, but I think there is no linker guarantee it will pick up=20
compat/fnmatch/fnmatch.o over the C runtime version?  Perhaps the=20
makefile is architected to do so.

The safest alternative is to allocate character buffers, lowercase the=20
filename and match arguments into those buffers, and pass them off to=20
fnmatch without any special flags.  I don't like the idea of a double=20
memory allocation/free combo per each call to this function, but it=20
would work.  Is anyone opposed to this approach?

Josh
