From: David Barr <davidbarr@google.com>
Subject: Re: Git performance results on a large repository
Date: Sun, 5 Feb 2012 22:24:45 +1100
Message-ID: <CAFfmPPMcS5Y8hoXyR8LY637z_f-A1XgrH6m+YUsCv8gmGjtr3w@mail.gmail.com>
References: <CB5074CF.3AD7A%joshua.redstone@fb.com>
	<alpine.DEB.2.02.1202042026280.6541@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joshua Redstone <joshua.redstone@fb.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: david@lang.hm
X-From: git-owner@vger.kernel.org Sun Feb 05 12:24:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ru0DD-0007ZR-J2
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 12:24:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754384Ab2BELYr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Feb 2012 06:24:47 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:50660 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754084Ab2BELYq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Feb 2012 06:24:46 -0500
Received: by ggnh1 with SMTP id h1so2426280ggn.19
        for <git@vger.kernel.org>; Sun, 05 Feb 2012 03:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:x-system-of-record:content-type:content-transfer-encoding;
        bh=RuP6ABH/i5XGnnfmmJQfvdrSfnedGSMA7DClIH80w6M=;
        b=x0fF3zwCHrKVV5e1YkSWy8bRRBiMK/+326VIWhjrbJlbducpe24eTaxyMvBp8bSets
         QK83S1ehGq3q/ByhelUJugr4pLClIOb1s0PTEH86GyoM4mO4bfWzHfviLjhvjz7DfRZd
         2Zf1VZEKUVhXGKAGlgErt2DPFVAVhlcgIByOk=
Received: by 10.100.245.37 with SMTP id s37mr637715anh.35.1328441085632;
        Sun, 05 Feb 2012 03:24:45 -0800 (PST)
Received: by 10.100.245.37 with SMTP id s37mr637707anh.35.1328441085480; Sun,
 05 Feb 2012 03:24:45 -0800 (PST)
Received: by 10.101.197.7 with HTTP; Sun, 5 Feb 2012 03:24:45 -0800 (PST)
In-Reply-To: <alpine.DEB.2.02.1202042026280.6541@asgard.lang.hm>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189939>

On Sun, Feb 5, 2012 at 3:30 PM,  <david@lang.hm> wrote:
> On Fri, 3 Feb 2012, Joshua Redstone wrote:
>
>> The test repo has 4 million commits, linear history and about 1.3 mi=
llion
>> files. =A0The size of the .git directory is about 15GB, and has been
>> repacked with 'git repack -a -d -f --max-pack-size=3D10g --depth=3D1=
00
>> --window=3D250'. =A0This repack took about 2 days on a beefy machine=
 (I.e.,
>> lots of ram and flash). =A0The size of the index file is 191 MB.
>
>
> This may be a silly thought, but what if instead of one pack file of =
your
> entire history (4 million commits) you create multiple packs (say eve=
ry half
> million commits) and mark all but the most recent pack as .keep (so t=
hat
> they won't be modified by a repack)
>
> that way things that only need to worry about recent history (blame, =
etc)
> will probably never have to go past the most recent pack file or two
>
> I may be wrong, but I think that when git is looking for 'similar fil=
es' for
> delta compression, it limits it's search to the current pack, so this=
 will
> also keep you from searching the entire project history.

I don't know if there is an easy way to determine with the with the
current tools
in git but one useful statistic for tuning packing performance is the
size of the
largest component in the delta-chain graph. The significance of this nu=
mber is
that the product of window-size and maximum depth need not be larger th=
an it.
I've found that with some older repositories I could have a depth as lo=
w as 3
and still get good performance from a moderate window size.

--
David Barr
