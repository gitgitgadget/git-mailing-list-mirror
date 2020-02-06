Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EC5C35247
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 22:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B1721927
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 22:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p62H3bxR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgBFWNM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 17:13:12 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:36124 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbgBFWNM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Feb 2020 17:13:12 -0500
Received: by mail-pj1-f68.google.com with SMTP id gv17so34837pjb.1
        for <git@vger.kernel.org>; Thu, 06 Feb 2020 14:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4xD8FxAJRFjDemiyKyCwQZuR3CwuP7rDIpCoeHJR4B4=;
        b=p62H3bxRrfvRqL9O22zZXs+XiVQzn4J58zWxhMnLRZVkGiKQYKTI3ElAU+aJY/tTz9
         SzR56CYXs+ysyZdTMASxyhvHo8phM1bvE9TdlM8DA6MZ7IfPMvfrO4yjHK0AKXL6s20Z
         E9z3KrZ64041Jdx3LMYa2/9Uc9nrpmYJp8FapFmorlXxzdiO4TA7mLuC5OAF1yJooKvZ
         HCLrQwT56RGPNSI+FLLT1B9/LJf1YNVqw+Oqs4Qg3E+B4iBBO9n6mtGv0fKHDCka5sNc
         bFFs/0swSYqpqqfJbYyF2VTLUf3tTZ+gaZ7GXeJdQP749FJSZShruqA/33x5xirHj03R
         w0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4xD8FxAJRFjDemiyKyCwQZuR3CwuP7rDIpCoeHJR4B4=;
        b=sZArENlCVzGaYj6GinJp1VNaNQXoGE4mAv+9RI8SJ7+MGHmZfXeQI1IWBVmqDR7wwf
         0hHRkk2FFZAes9vkDw3bqs1JW3kISr2opKYa+HvsyEoKP3PumPoytMMqNpYorwjcgGya
         w3KAOoA05vc32AvBSSoMJl05XEEs6G9DHMHQo6216NJBLRSBoEisS3BiBYpqYaZXsFfj
         obPD5seACx7F/I5OhpnYeSD3WN8qIDQsK7pCFpU11o5TkW4z4AKwP6s9U1BgQ1IqrgOa
         tdhhOIdBksUIzYI+IdT+s40AB+ren/xKE/Xu/Gewt3ruyY5/VEhgIjYXdtsQzouslKyv
         mncw==
X-Gm-Message-State: APjAAAUemG6Xo+fZ3rqCA7B0dNEZOJZehLMs3D+6BXWMHpMcVRelI8uB
        QbCMI4TxMHI4KBCLPoZmyV0FLQ==
X-Google-Smtp-Source: APXvYqxHHcMPa/Q5VJxoPaD8fOe0LrPVwoIiwJf6aa3UHxRIbHzvC8AwnWHSJDoAvrVSijF73myIIQ==
X-Received: by 2002:a17:90a:7d07:: with SMTP id g7mr7356928pjl.17.1581027191166;
        Thu, 06 Feb 2020 14:13:11 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id a35sm378683pgl.20.2020.02.06.14.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 14:13:09 -0800 (PST)
Date:   Thu, 6 Feb 2020 14:13:05 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v7] MyFirstContribution: add avenues for getting help
Message-ID: <20200206221305.GB190927@google.com>
References: <20200124210148.220007-1-emilyshaffer@google.com>
 <20200124212602.74194-1-emilyshaffer@google.com>
 <20200124215628.GI6837@szeder.dev>
 <xmqqh80kctcn.fsf@gitster-ct.c.googlers.com>
 <20200206010704.GN10482@szeder.dev>
 <xmqqh803fzf1.fsf@gitster-ct.c.googlers.com>
 <20200206194929.GA190927@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200206194929.GA190927@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 06, 2020 at 11:49:29AM -0800, Emily Shaffer wrote:
> On Thu, Feb 06, 2020 at 08:33:54AM -0800, Junio C Hamano wrote:
> > SZEDER Gábor <szeder.dev@gmail.com> writes:
> > 
> > > On Fri, Jan 24, 2020 at 03:44:40PM -0800, Junio C Hamano wrote:
> > >
> > >> ...  The more important part, from my point of view,
> > >> is that we offer choices (the proposed doc update illustrates
> > >> three).
> > >
> > > I remember a discussion about whether that list and its archive should
> > > be open or closed, and I agree that offering choices is good.
> > > However, since that mentoring list requires registration, we have to
> > > carefully consider how to present it to newcomers.
> > >
> > > Openly accessible knowledge is a fundamental value, and it's the
> > > foundation of open source.  Therefore, we definitely should not direct
> > > newcomers to a closed mailing list as the first option, it can only be
> > > a fallback.
> > 
> > I am not that dogmatic ;-) I would be very unhappy and probably
> > would not have joined if the main development community was closed,
> > but I do not think the "knowledge" the "closed mentoring list for
> > those who are shy" are meant to impart to newbies will be something
> > that will be so well kept secret that are shared among only those in
> > the closed list.  I expect the mentoring list to be repeating what
> > those who graduated "new"-ness consider pretty much common public
> > knowledge.
> > 
> > Having said that, my reading did hiccup when queuing Emily's text,
> > in that it listed the mentoring list first, and (more problematic)
> > the only choice among the three described with a word "great" was
> > that one.  Also, now I re-read it, the last sentence "You must join
> > the group to view messages or post", without explaining why it is
> > set up that way is bound to give a wrong impression, I suppose.  I
> > presume that the reason why those who wanted to make the mentoring
> > list closed was because they thought it would be nicer for shysters,
> > but if that is the case, it probably is better to spell that out.
> 
> Sure. I think I didn't do so in an effort to be brief. I'll think on
> this today and send some suggestions here (rather than rerolling).
> 
> > 
> > > The text should list git@vger as the first option, since that's the
> > > only open mailing list we have, it should clearly emphasize that
> > > newcomers are very welcome, and should explicitly encourage them to
> > > post their questions here, no matter how trivial or silly they think
> > > those questions are, we'll be always glad to answer them.
> > 
> > I have no problem with seeing an expanded invitation to the main
> > list.  I do not have a strong opinion on the order of three items.
> 
> Me neither, and placing git@vger first does give me an opportunity to
> say something like "if you feel worried about asking publicly, this list
> is a more private setting" in reference to the mentors list. So that's
> an option I could get behind.

How about something like this?

I was trying to achieve the following goals:

 - Try to remove bias:
   - Don't make git@vger sound like a last-ditch effort or scary place.
   - Don't call git-mentoring@ "great", rather explain why it was
     created
   - Don't imply that all contributors who want to help are present on
     mentoring list, or that all contributors who aren't present on
     mentoring list don't want to help - just indicate that all
     contributors on mentoring list do want to help
 - Explain reasoning around git-mentoring@:
   - avoiding the public eye (and that's why viewing is restricted)
   - targeted membership (people joined because they want to help)

I'm no professional writer, so I expect there's more work to be done.
When we have something we're happy with then I'll send a formal patch.

 - Emily

-- >8 --

---
 Documentation/MyFirstContribution.txt | 29 +++++++++++++++------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 522c75099d..427274df4d 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -28,11 +28,24 @@ useful additional context:
 
 If you get stuck, you can seek help in the following places.
 
+==== git@vger.kernel.org
+
+This is the main Git project mailing list where code reviews, version
+announcements, design discussions, and more take place. Those interested in
+contributing are welcome to post questions here. The Git list requires
+plain-text-only emails and prefers inline and bottom-posting when replying to
+mail; you will be CC'd in all replies to you. Optionally, you can subscribe to
+the list by sending an email to majordomo@vger.kernel.org with "subscribe git"
+in the body. The https://lore.kernel.org/git[archive] of this mailing list is
+available to view in a browser.
+
 ==== https://groups.google.com/forum/#!forum/git-mentoring[git-mentoring@googlegroups.com]
 
-This mailing list is targeted to new contributors and is a great place to post
-questions and receive kind, detailed answers from volunteers on the Git
-project. You must join the group to view messages or post.
+This mailing list is targeted to new contributors and was created as a place to
+post questions and receive answers outside of the public eye of the main list.
+Veteran contributors who are especially interested in helping mentor newcomers
+are present on the list. In order to avoid search indexers, group membership is
+required to view messages; anyone can join and no approval is required.
 
 ==== https://webchat.freenode.net/#git-devel[#git-devel] on Freenode
 
@@ -46,16 +59,6 @@ respond to you. It's better to ask your questions in the channel so that you
 can be answered if you disconnect and so that others can learn from the
 conversation.
 
-==== git@vger.kernel.org
-
-This is the main Git project mailing list where code reviews, version
-announcements, design discussions, and more take place. The Git list
-requires plain-text-only emails and prefers inline and bottom-posting when
-replying to mail; you will be CC'd in all replies to you. Optionally, you can
-subscribe to the list by sending an email to majordomo@vger.kernel.org with
-"subscribe git" in the body. The https://lore.kernel.org/git[archive] of this
-mailing list is available to view in a browser.
-
 [[getting-started]]
 == Getting Started
 
-- 
2.25.0.341.g760bfbb309-goog

