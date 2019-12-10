Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC650C43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 12:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52DE20828
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 12:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfLJMC1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 07:02:27 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:57871 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfLJMC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 07:02:27 -0500
X-Originating-IP: 157.36.75.244
Received: from localhost (unknown [157.36.75.244])
        (Authenticated sender: me@yadavpratyush.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id D0A1340003;
        Tue, 10 Dec 2019 12:02:24 +0000 (UTC)
Date:   Tue, 10 Dec 2019 17:32:19 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Vasili Novikov <vasilii.novikov@zivver.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-gui: allow closing console window with Escape
Message-ID: <20191210120219.zc4k5dih25ae3da6@yadavpratyush.com>
References: <20191206222040.toj4enbbbbamnrww@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1912071723010.31080@tvgsbejvaqbjf.bet>
 <20191208194046.csf35b7rgycst2vc@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1912091014220.31080@tvgsbejvaqbjf.bet>
 <1313cb5b-9d6a-f038-bda3-757b4e55bf33@zivver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1313cb5b-9d6a-f038-bda3-757b4e55bf33@zivver.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Vasili,

Please try to not top-post on the list.

On 09/12/19 04:53PM, Vasili Novikov wrote:
> What have console windows to do with git gui though? I'd work under the

Well, the window/popup in question is internally named "console" and is 
defined in lib/console.tcl. It is used by many parts of git-gui that 
need to execute a command and show the output to the user.

> following assumptions:
> * we're talking about a GUI window, not a TUI one
> * the window has no useful information at all except the fact that something
> has "finished", is "done". There are no actions that you can take except to
> dismiss the window.
 
It also shows you the output of a command currently in progress (like 
git-push). My main argument with avoiding Escape is that people often 
expect Escape to stop an ongoing command. In this case though, closing 
the window does not actually stop the command. It keeps going on in the 
background.

But since the window is gone, people might think the command they were 
running has stopped, which might lead to some unexpected results.

> If we agree on the following assumptions, then I see these real-world
> examples:
> * Mousepad > About > Esc = closes the popup
> * Firefox > About > Esc = closes the popup
> * Thunar > select any file and ask its properties > Esc = closes the window
> * file-roller (GNOME compressed archive manager) > Extract archive > Observe
> success window upon completion > Esc = closes the window.

In this case, the thing is done. There is no ongoing task. Not quite the 
case with the console window in git-gui, which can also show ongoing 
tasks.
 
> Are there any real-world examples where `Ctrl W` or `Esc D` work but `Esc`
> doesn't, to consider these alternatives as more intuitive to users?
> 
> 
> On 09/12/2019 10.18, Johannes Schindelin wrote:
> > Hi Pratyush,
> > 
> > On Mon, 9 Dec 2019, Pratyush Yadav wrote:
> > 
> > > On 07/12/19 05:24PM, Johannes Schindelin wrote:
> > > > 
> > > > On Sat, 7 Dec 2019, Pratyush Yadav wrote:
> > > > 
> > > > > It is often expected that popup windows like the console window be
> > > > > close-able with Esc.
> > > > 
> > > > Seeing as the console windows is not your regular popup window with an
> > > > "OK" button, I could see how it would be all too easy to close the window
> > > > via the Esc button all too easily, annoying users.
> > > 
> > > I'm not sure why it is "too easy" to hit Escape. If you're hitting Esc
> > > (which for most people is pretty far from other more frequently used
> > > keys) you expect _something_ to happen. People don't just spam Esc for
> > > no reason, do they?
> > 
> > Is it possible to issue a command in that console window? If yes, Esc D is
> > what people like me would possibly use to delete entire words.
> > 
> > Even if not, if there is no "OK" button, it would annoy me no end if the
> > Escape key closes the window (it is not a dialog box, after all).
> > 
> > > > For windows like the console one, I would expect Ctrl+W a much more
> > > > natural keyboard shortcut to close it.
> > > 
> > > But, that "something" the user expects to happen could also be "stop the
> > > command". AFAIK, Esc is often expected to stop commands. But closing the
> > > console window won't actually stop the command. It will keep running in
> > > the background, and when the command is done, the window will open again
> > > showing the final output.
> > > 
> > > So all in all, I do think Ctrl-W would be a better idea. Will re-roll.
> > 
> > Thank you,
> > Dscho
> > 
> 
> -- 
> Vasilii Novikov
> Software Developer
> vasilii.novikov@zivver.com
> 
> ZIVVER B.V. • Koningin Wilhelminaplein 30 • 1062 KR Amsterdam
> www.zivver.com • +31 85 01 60 555 <+31-85-0160555>
> Follow us on: twitter <https://twitter.com/zivver_nl>, facebook
> <https://www.facebook.com/zivver> and linkedin
> <https://www.linkedin.com/company/zivver>
> 
> ✓ Voldoe jij al aan de GDPR-wetgeving?
> <https://get.zivver.eu/nl/gdpr-checklist/>

-- 
Regards,
Pratyush Yadav
