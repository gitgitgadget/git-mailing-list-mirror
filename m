From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 2/3] sha1_name: get_sha1_with_context learns to follow
 symlinks
Date: Fri, 08 May 2015 16:27:09 -0400
Organization: Twitter
Message-ID: <1431116829.9179.12.camel@ubuntu>
References: <1431108819-6831-1-git-send-email-dturner@twopensource.com>
	 <1431108819-6831-2-git-send-email-dturner@twopensource.com>
	 <CAPig+cRzXQp_afDrOdKrUQ-=DD1P_UcDzs8aSZnTfesd7R20wQ@mail.gmail.com>
	 <CAPc5daXmJSfdB_eyQ5ppVp2NhYGZvPChGAyn4p2hEde=4x9EEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 08 22:28:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yqord-0000SV-2u
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 22:27:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547AbbEHU1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 16:27:13 -0400
Received: from mail-qc0-f180.google.com ([209.85.216.180]:35730 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932219AbbEHU1M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 16:27:12 -0400
Received: by qcbgu10 with SMTP id gu10so42823200qcb.2
        for <git@vger.kernel.org>; Fri, 08 May 2015 13:27:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=WVQ8/HANeIK9+vc4WGUSOGN08kam6yiiqyL0KdFuzXU=;
        b=G1GLzYXrcMy803qLNQhn5yDeUtpdxsKJ7rutVXeV42oxfvElxkCoVj+sa5q7+F6ODN
         NigpXkuZkM3eXzEJ+HotsBsSByxwghcUEfYwjZCUMiWcB9C/S0K/qZUtpVw+8ozZHnRn
         BI7fWNeZQCB6E9U7Biig5QVxBjDefhqiXTdzJAS3AkZrIYQf+Gpb0ZJlArTBZuY1wj35
         /TGM6cCI6QUzYEyl5Es5QWoT1p/kPKqALfzMWM8iauoROyxd1/EpEUlCGuQj2mVKkceA
         n4ZbSgRyOIDUOFR0SoPAtijtJuQZ56RBdIfwsorz8e54PnEJDXtaxKJmOWiGlJxu5/cs
         kBow==
X-Gm-Message-State: ALoCoQm1DsXqS1EZ5/+lTNs4u1mTIZXdXGCCYVSfUeUM173GldQ0GMyiK+f2Gvi/k88F0hCPzjCa
X-Received: by 10.140.43.100 with SMTP id d91mr7303598qga.77.1431116831615;
        Fri, 08 May 2015 13:27:11 -0700 (PDT)
Received: from [172.22.38.222] ([192.133.79.147])
        by mx.google.com with ESMTPSA id 188sm4328601qhh.48.2015.05.08.13.27.10
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2015 13:27:10 -0700 (PDT)
In-Reply-To: <CAPc5daXmJSfdB_eyQ5ppVp2NhYGZvPChGAyn4p2hEde=4x9EEQ@mail.gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268661>

On Fri, 2015-05-08 at 13:17 -0700, Junio C Hamano wrote:
> On Fri, May 8, 2015 at 12:45 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> >> +       if (flags & GET_SHA1_FOLLOW_SYMLINKS && flags & GET_SHA1_ONLY_TO_DIE)
> >> +               die(_("internal error: bad flags for get_sha1_with_context"));
> >
> > There may not be much value in marking an "internal error" string for
> > translation.
> 
> The whole point of this kind of messages is so that the end users,
> when they see it trigger, can notify us and then to allow us to
> identify which die() triggered.  It is not just "may not be much
> value in", but is actively unproductive to make it translatable,
> even if we ignore the cost to i18n/l10n teams to translate such
> messages.
>
> By the way, we would want to standardise the string before the
> colon, so that we can tell users "If you see an error message that
> begins with 'internal error:', please report that to us---it is a
> programming error".  I think the majority of existing code uses the
> string "BUG:" for that, and I do not mind using 'internal error:'
> for that purpose instead, but the important thing is to use just one
> single string thoughout the codebase, so that the "please report
> when you see this" message we give the users can be simple.

It appears that "BUG:" is preferred to "internal error:" by a margin of
2:1.  So I'll change it.  Fixing the remaining ~40 instances of
"internal error" would be a great project for someone new to git
development.

>From an i18n perspective, I think the correct thing to do would be to
i18n the "BUG" portion and nothing else.  That way, users can understand
what has happened, but if they report it upstream, git developers know
where in the code to look.  But this would probably be complicated to
implement, so maybe not worthwhile.
