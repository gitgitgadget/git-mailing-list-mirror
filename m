X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [RFC \ WISH] Add -o option to git-rev-list
Date: Mon, 11 Dec 2006 08:17:15 +0100
Message-ID: <e5bfff550612102317w331f3b0fyc3c6b095ff21191a@mail.gmail.com>
References: <e5bfff550612100338ye2ca2a0u1c8f29bbc59c5431@mail.gmail.com>
	 <e5bfff550612101151r5e77ddc0w8f61f36fc1f2920e@mail.gmail.com>
	 <Pine.LNX.4.64.0612101159530.12500@woody.osdl.org>
	 <Pine.LNX.4.64.0612101213520.12500@woody.osdl.org>
	 <e5bfff550612101405h507cc877k87491264d11b0aa8@mail.gmail.com>
	 <Pine.LNX.4.64.0612101410220.12500@woody.osdl.org>
	 <e5bfff550612101435o6bc938acmac28ad6adf0c8844@mail.gmail.com>
	 <Pine.LNX.4.64.0612101439540.12500@woody.osdl.org>
	 <e5bfff550612101615u5f588513n499e3b88ce14a6f6@mail.gmail.com>
	 <Pine.LNX.4.64.0612101647310.12500@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 07:17:28 +0000 (UTC)
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>,
	"Alex Riesen" <raa.lkml@gmail.com>,
	"Shawn Pearce" <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ctufioQD/DZBOhObZ92Lq6DwGur8jTe1PmfZyvUutK/Tn3Wv7asj7PZycXKOuT0DbDkiC747PVatOCykBQKNpzLOqHAkPEpAF/vVofmUgFCdqh3N4I1I+4/GALl4942cX42nJX46JMYrcZVOsiLcMIeeeXw+lMBSScMcHHrCruo=
In-Reply-To: <Pine.LNX.4.64.0612101647310.12500@woody.osdl.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33975>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtfPi-0002hx-G3 for gcvg-git@gmane.org; Mon, 11 Dec
 2006 08:17:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762611AbWLKHRR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 02:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762614AbWLKHRR
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 02:17:17 -0500
Received: from py-out-1112.google.com ([64.233.166.183]:5284 "EHLO
 py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1762611AbWLKHRQ (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec
 2006 02:17:16 -0500
Received: by py-out-1112.google.com with SMTP id a29so864094pyi for
 <git@vger.kernel.org>; Sun, 10 Dec 2006 23:17:15 -0800 (PST)
Received: by 10.35.121.2 with SMTP id y2mr9609124pym.1165821435698; Sun, 10
 Dec 2006 23:17:15 -0800 (PST)
Received: by 10.35.93.11 with HTTP; Sun, 10 Dec 2006 23:17:15 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On 12/11/06, Linus Torvalds <torvalds@osdl.org> wrote:

>
> How about you just compare something simpler:
>
>         git-rev-list | cat > /dev/null
>
> vs
>
>         git-rev-list > tmpfile ; cat tmpfile > /dev/null
>
> and see which one works better.
>

These are tipical values (warm cache):

  $ time git rev-list --header --boundary --parents --topo-order HEAD  /dev/null
3.04user 0.05system 0:03.09elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+10141minor)pagefaults 0swaps

$ time git rev-list --header --boundary --parents --topo-order HEAD |
cat > /dev/null
3.67user 0.36system 0:04.29elapsed 93%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+18033minor)pagefaults 0swaps

$ time git rev-list --header --boundary --parents --topo-order HEAD >
/tmp/tmp.txt; cat /tmp/tmp.txt > /dev/null
3.44user 0.28system 0:03.74elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+18033minor)pagefaults 0swaps

For some reason the CPU *never* goes up 93% with pipe (while it's easy
in the other two cases) and I repeated that test at lest 10 times
consecutively. Is it perhaps the signature of some blocking around? Or
too much high frequency of receiver's read call (see below) ?

>
> This is your problem:
>
> >               guiUpdateTimer.start(100, true);
>
> rather than just blindly starting a timer, you should ask it to wait until
> more data is available.
>

OK. I just don't understand how after waiting 100ms I get only 60KB
and stay in the loop only one cycle instead of reading, for many
cycles, much more then 60KB and then wait another 100ms and found
another big (about 1MB) amount of data ready to be read as with the
file case.

Perhaps the pipe buffers are small and block the writer when full. In
the file case when I come back in the loop after 100ms I found _a lot_
of data to be read and I stay in the loop for much more then 1 cycle
before to wait again 100ms.

On the other hand, going to read each say less then 10ms is exactly
what QProcess (socket based) was doing and I ended up with my read
function being called at furious pace slowing down everything.
Experimenting with QProcess I found that, for performance reasons,
it's better to read big chunks few times then small chunks a lot of
times.

  Marco

P.S: 30MB for 64KB each chunk it's 468, in 3.67s it's 1 call each
7.8ms. If the pipe calls the receiver for data ready after each 4KB
(old kernels) then we should have 7.500 calls. Impossible to read in
3.67s, it would be a theoretical 1 call each 0.48ms average.

So IMHO bigger buffers for each read call could be the way to get
