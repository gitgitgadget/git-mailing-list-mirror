X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [RFC \ WISH] Add -o option to git-rev-list
Date: Mon, 11 Dec 2006 19:59:22 +0100
Message-ID: <e5bfff550612111059g35f1aa2dmdead17a60f5dfca8@mail.gmail.com>
References: <e5bfff550612100338ye2ca2a0u1c8f29bbc59c5431@mail.gmail.com>
	 <e5bfff550612101435o6bc938acmac28ad6adf0c8844@mail.gmail.com>
	 <Pine.LNX.4.64.0612101439540.12500@woody.osdl.org>
	 <e5bfff550612101615u5f588513n499e3b88ce14a6f6@mail.gmail.com>
	 <Pine.LNX.4.64.0612101647310.12500@woody.osdl.org>
	 <e5bfff550612102317w331f3b0fyc3c6b095ff21191a@mail.gmail.com>
	 <Pine.LNX.4.64.0612110855550.12500@woody.osdl.org>
	 <Pine.LNX.4.64.0612110905180.12500@woody.osdl.org>
	 <e5bfff550612110939r58df1a73ud28983633c12e487@mail.gmail.com>
	 <Pine.LNX.4.64.0612111003140.12500@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 18:59:33 +0000 (UTC)
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>,
	"Alex Riesen" <raa.lkml@gmail.com>,
	"Shawn Pearce" <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N5tTSruab9+9FhLT/sV6O6w2WDj7TMwUXOgiDbTzz23hnheWoDaJveiXw0QjdYDD+mlJ3NkFM4AX2Blo451nleb3wpZsgNYaBfzUGuwaGARAbsH3romPxjhjHrV8saPW012VquOIxTG8i/xxb59SQNLGpK1eSqviCTKInM+k75c=
In-Reply-To: <Pine.LNX.4.64.0612111003140.12500@woody.osdl.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34028>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtqN5-000496-MK for gcvg-git@gmane.org; Mon, 11 Dec
 2006 19:59:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937501AbWLKS7Y (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 13:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937102AbWLKS7Y
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 13:59:24 -0500
Received: from nz-out-0506.google.com ([64.233.162.233]:3181 "EHLO
 nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with
 ESMTP id S937501AbWLKS7X (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec
 2006 13:59:23 -0500
Received: by nz-out-0102.google.com with SMTP id s1so847126nze for
 <git@vger.kernel.org>; Mon, 11 Dec 2006 10:59:22 -0800 (PST)
Received: by 10.35.115.18 with SMTP id s18mr13066100pym.1165863562765; Mon,
 11 Dec 2006 10:59:22 -0800 (PST)
Received: by 10.35.93.11 with HTTP; Mon, 11 Dec 2006 10:59:22 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On 12/11/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
>
> However, you seem to continually ignore the thing I've asked you to do
> several times: try with a cold-cache situation.

Yes. I will test it. I was testing with warm cache also to my
curiosity about comparing pipes with temporary file reading as data
exchange facility. So I needed to avoid HD artifacts.

>
>
>   At that point, you'd actually do something that gitk can't do at all,
>   namely work well for the cold-cache not-very-packed large-repository
>   case. ]
>

Removing --topo-order from launch parameters is very simple, see from
gitstartup.cpp:

bool Git::startRevList(SCRef args, FileHistory* fh) {

	QString initCmd("git rev-list --header --boundary --parents ");
	if (!isMainHistory(fh)) {
		// fetch history from all branches so any revision in
		// main view that changes the file is always found
		SCRef allBranches = getAllRefSha(BRANCH).join(" ");
		initCmd.append("--remove-empty " + allBranches + " -- ");
	} else
		initCmd.append("--topo-order ");

	return startParseProc(initCmd + args, fh);
}

It is already removed from file history fetching because there the
history it's _almost_ linear and you gain the speed without noticing
the different graph layout. But for main view I fear that complicated
branch structures could became difficult to follow without
--topo-order. Perhaps an option in settings?

> To see this in practice (even with hot-caches), do something like the
> following on the full historic Linux archive:
>
>         time sh -c "git rev-list HEAD | head"
>         time sh -c "git rev-list --topo-order HEAD | head"
>
> where for me, the firstone takes 0.002s, and the second one takes 0.878s.
>

This is  the data:

$ pwd
/git/linux-2.6
bash-3.1$ time sh -c "git rev-list HEAD | head"
200d018eff4be3a1fb9823441cfcebb7de86a677
f0647a52974daccbe20990fb6341f07792445fe0
c25c79d80e02db1bd993426f979c5f1b42a0f132
9fd32cfbb602f3e5e898faa61d83c4a7897bd48a
ed99e2bc1dc5dc54eb5a019f4975562dbef20103
773ff78838ca3c07245e45c06235e0baaa5f710a
52ffe760ea9ec407292d093c3f06c1cda5187228
14b36af46a1d3652aff6734ea24816995dff8123
eb991b39385c7b04923d701764a34694ec54b53d
88032b322a38b37335c8cb2e3473a45c81d280eb
0.08user 0.02system 0:00.10elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+3631minor)pagefaults 0swaps

bash-3.1$  time sh -c "git rev-list --topo-order HEAD | head"
200d018eff4be3a1fb9823441cfcebb7de86a677
f0647a52974daccbe20990fb6341f07792445fe0
c25c79d80e02db1bd993426f979c5f1b42a0f132
9fd32cfbb602f3e5e898faa61d83c4a7897bd48a
ed99e2bc1dc5dc54eb5a019f4975562dbef20103
773ff78838ca3c07245e45c06235e0baaa5f710a
52ffe760ea9ec407292d093c3f06c1cda5187228
14b36af46a1d3652aff6734ea24816995dff8123
eb991b39385c7b04923d701764a34694ec54b53d
33ec32fae0e2c4433bfd1e74cbde6cb16604a719
2.84user 0.12system 0:03.05elapsed 97%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+12086minor)pagefaults 0swaps

Also the long awaited ;-)

$ time sh -c "git rev-list --header --boundary --parents --topo-order
HEAD | cat > /dev/null"
3.75user 0.55system 0:04.42elapsed 97%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+18822minor)pagefaults 0swaps

$ time sh -c "git rev-list --header --boundary --parents --topo-order
HEAD > /tmp/tmp.txt; cat /tmp/tmp.txt > /dev/null"
3.50user 0.30system 0:03.92elapsed 97%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+18800minor)pagefaults 0swaps


