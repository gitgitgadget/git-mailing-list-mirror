From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: bug: git-archive does not use the zip64 extension for archives
 with more than 16k entries
Date: Wed, 12 Aug 2015 21:40:48 +0200
Message-ID: <55CBA140.7050301@web.de>
References: <20150811104056.16465.58131@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Johannes Schauer <josch@debian.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 12 21:41:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPbta-0001wZ-7x
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 21:41:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbbHLTlA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Aug 2015 15:41:00 -0400
Received: from mout.web.de ([212.227.17.11]:52677 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751442AbbHLTk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 15:40:59 -0400
Received: from [192.168.178.37] ([79.253.188.251]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0Lj2I6-1YodmQ3b0I-00dFo2; Wed, 12 Aug 2015 21:40:56
 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <20150811104056.16465.58131@localhost>
X-Provags-ID: V03:K0:PxsXA2n+Fl65EBUIR5mHKRC6+JIFOXaMSEvjUo1cbifjufIDoCl
 9eGC2pp9J9koT6tn2j/375HjpB8hWiHBdqv5RnxM2r9gJTLq4juqn7N1+Lm3r0wX1gdWrwd
 VwI1BkTVO2R0kN6JkBC4B58bWbg4xFwe28AhizJNZFrGYR0dhhMRzZ6wgH2k/VE0kwHQwXr
 Xi4CLVpTA+PkuAE4qWq8A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jVvOhHFrBOU=:NvACjz9G97UQxuMOhiKSGa
 EXq4hYROEH6vRc2mh6R5YyqQYkSGAcVu4AzUlAD/gdG4o+MhQ6jaN7GUxWcIR0J9ofOkLRDcE
 gUvzPVEmzSnYF57bIG59cjD+tsDIioHz2Z7i2Vw9j3WQNccH7vaSfNda9ZAYI5z/g+0MxGz3o
 KKWh2RTr/IMydCzuOUwe8Edt65M0py9qXKtnlWP8QsKJqZFc8Mjh0GUOYJJQEqtVdF4ibf27q
 pbuJksytvIZ8xJ8rg9+ycaTf/zUa1mvYZRtItdFOiyNj1r1QfQyREkJrXVz0sUSmpDpG5WfXR
 J5thlySC+2o9ME+XSaIZeTGwHwvJ62CYXVXBknplnajZ40MLtr0AIcWgFkNemC/ydYWCldree
 8RlUCbbmADeTBTFfrMDrgF6x+5uQ/GADG9yO08W8iu1BnZJprvV/jjjPaNmopThyA6NiE955I
 5khv624uLpab6fwjpd3TsVB1pedDP1R5JeYW3yDNX3fyrdjNIZVsPK2ZYllSy1xP/sNiQ8lWH
 s6BPLQXGJNueRgWjDfrCxcFCiSLM5WKMh58TDlV2axS/7Atk3/zRyVHmHlxoPNdRJifjTke+q
 5JaIZ12aqrtG7HJHeKzgA53ucb6HJ593ZypznkkCgrc4OjrzFilNgmBRA2mIr7I2wYw0syjzm
 8v7xGu6l0dnZONf3m+mZr2igLr/FKSuLGZ7QRc0k2bA2gpAGK4EAkiq2Y6DCx2Im+gymV9Few
 iSX1fnKjJjxzpVrz42xARNaRn8X5ekNEXkejuw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275805>

Am 11.08.2015 um 12:40 schrieb Johannes Schauer:
> Hi,
>
> for repositories with more than 16k files and folders, git-archive wi=
ll create
> zip files which store the wrong number of entries. That is, it stores=
 the
> number of entries modulo 16k. This will break unpackers that do not i=
nclude
> code to support this brokenness.

The limit is rather 65535 entries, isn't it?  The entries field has two=
=20
bytes, and they are used fully.

Which programs are affected? InfoZIP Zip 3.0 and 7-Zip 9.20 seem to=20
handle an archive with more entries just fine.  The built-in=20
functionality of Windows 10 doesn't.

Besides, 64K entries should be enough for anybody. ;-)

Seriously, though: What kind of repository has that many files and uses=
=20
the ZIP format to distribute snapshots?  Just curious.

> Instead, git-archive should use the zip64 extension to handle more th=
an 16k
> files and folders correctly.

That seems to be what InfoZIP does and Windows 10 handles it just fine.=
=20
  If lower Windows versions and other popular extractors can unzip such=
=20
archives as well then this might indeed be the way to go.

Thanks,
Ren=E9
