X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Allow hand-editing of patches before sending
Date: Sun, 5 Nov 2006 12:43:53 +0100
Message-ID: <20061105114353.GB19707@diana.vm.bytemark.co.uk>
References: <20061101090046.1107.81105.stgit@localhost> <b0943d9e0611020232x1e343bbco9451c8183c84d68@mail.gmail.com> <20061102113631.GA30507@diana.vm.bytemark.co.uk> <b0943d9e0611030139i7be9569bh4a29596a768e82a3@mail.gmail.com> <20061103095859.GC16721@diana.vm.bytemark.co.uk> <20061103100142.GD16721@diana.vm.bytemark.co.uk> <454B30E4.8000909@shadowen.org> <454B4C43.2040607@shadowen.org> <Pine.LNX.4.64.0611031034520.25218@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 5 Nov 2006 11:44:26 +0000 (UTC)
Cc: Andy Whitcroft <apw@shadowen.org>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611031034520.25218@g5.osdl.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30973>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GggQB-0003KM-SZ for gcvg-git@gmane.org; Sun, 05 Nov
 2006 12:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932668AbWKELoM convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006 06:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932669AbWKELoM
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 06:44:12 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:10515 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S932668AbWKELoL
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2006 06:44:11 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1GggPp-0005Le-00; Sun, 05 Nov 2006 11:43:54 +0000
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On 2006-11-03 10:48:49 -0800, Linus Torvalds wrote:

> If your ISP mailer doesn't answer with "8BITMIME" to your EHLO, your
> mail client is supposed to downgrade to a 7-bit format (or the same
> thing can happen anywhere in between on one of the other hops). Of
> course, that would be a really old and broken mailer, and if you
> find one of those at the ISP you use, you should probably switch
> ISPs.
>
> Some other mailers have other issues, and qmail for example is
> apparently totally broken (it accepts 8-bit input, but cannot
> forward it properly to somebody who wants it converted to 7-bit).
>
> And some of us use "fetchmail" and ask it do do mimedecode for us,
> so that even if it arrived as 7-bit crud, we don't have to see it.
> So the fact that some people see it as 8-bit can be because the hops
> to them didn't involve a broken remailer, but it could also be
> because something in between (like fetchmail) tries to fix it up
> after the fact.
>
> That said: it tends to be unusual to see true 7-bit mailer setups
> these days.
>
> So the most _likely_ cause of unnecessary 7-bit QP crud is not in
> fact a 7-bit mailserver, but usually just the mail client that is
> just lazy and just sends out everything as 7-bit because it's too
> bothersome to even look at whether the mail server supports 8-bit
> data. Check your Thunderbird settings - it's quite possible that
> there's a flag there somewhere to turn on 8-bit mail transfers.

So the right thing to do would be to teach StGIT to generate
8bit-encoded output, and trust the SMTP transfer path do mangle it
correctly? (Hmm. No, since StGIT talks directly with the first SMTP
server in the chain, it needs to be able to QP-encode the mail itself
if necessary -- but it should seldom be necessary, then.)

In that case, the problem with the current implementation (without my
patch applied) is likely to be that it fails to provide the headers
needed for the SMTP path to be able to transform it losslessly.

[ ... digs through old mail ... ]

This is the interesting part of such a mail that was sent from my
computer, passed through the list, and ended up back at my computer
again:

  Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpa=
nd
          id S1750700AbWJVMCV (ORCPT <rfc822;kha-list-git@hemma.treskal=
=2Ecom>);
          Sun, 22 Oct 2006 08:02:21 -0400
  X-Warning: Original message contained 8-bit characters, however durin=
g
             the SMTP transport session the receiving system did not an=
nounce
             capability of receiving 8-bit SMTP (RFC 1651-1653), and as=
 this
             message does not have MIME headers (RFC 2045-2049) to enab=
le
             encoding change, we had very little choice.
  X-Warning: We ASSUME it is less harmful to add the MIME headers, and
             convert the text to Quoted-Printable, than not to do so,
             and to strip the message to 7-bits.. (RFC 1428 Appendix A)
  X-Warning: We don't know what character set the user used, thus we ha=
d to
             write these MIME-headers with our local system default val=
ue.
  MIME-Version: 1.0
  Content-Transfer-Encoding: QUOTED-PRINTABLE
  Content-Type: TEXT/PLAIN; charset=3DISO-8859-1
  Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780A=
bWJVMCV
          (ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 08:02:21 -040=
0

The mail server (vger talking to itself, if the Received: headers were
added in order) complained that there were no MIME headers, so it had
to guess the charset. As it happened, it guessed wrong, so the
non-ascii characters of the mail body was garbled.

My stab at fixing this was to make StGIT QP-encode the mail from the
outset, but if I've not misunderstood things yet again, the actual
problem was that StGIT did not produce the right MIME headers.

--=20
Karl Hasselstr=F6m, kha@treskal.com
