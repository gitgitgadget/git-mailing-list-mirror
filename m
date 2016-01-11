From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 3/3] builtin/grep: allow implicit --no-index
Date: Mon, 11 Jan 2016 18:48:17 +0100
Message-ID: <20160111174817.GC10612@hank>
References: <1452435597-12099-1-git-send-email-t.gummerer@gmail.com>
 <1452435597-12099-4-git-send-email-t.gummerer@gmail.com>
 <CACsJy8Bs3z0Gk3CjhyZGfOLA7R3pZQz7K5gk4BTytvYkZeyBtQ@mail.gmail.com>
 <20160111111015.GA10612@hank>
 <xmqqlh7wxc0y.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 18:48:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIgZS-0005Hf-VP
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 18:47:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760876AbcAKRrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 12:47:55 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32924 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760266AbcAKRry (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 12:47:54 -0500
Received: by mail-wm0-f67.google.com with SMTP id u188so27310648wmu.0
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 09:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=SxBnkVqSbIUZFGBSmDKnyc9vMJqBJ5JcOHBkJLcHSsc=;
        b=jyiN/ldBPg+J9xYkl8LDhHxNsDk2iHFzSLuJFrE3sqeesHLlD+D+W/Nu0lYXV7CVsh
         KH5n9v8Rrn2TG+1AOrMBi3+bmJLrivgE7oIkwwd2xjMO3yzMiDm7ZjUfkOMU+7KspD5h
         RexEMJJEYmsqsQ+XPvgA0fKS49ohVaecU3qO7dwuAc4H0X0uo9Icxu67H1sZGia71zE4
         BACar6l95FV5S7xEAcSUUt1ad4eRC5/9F1YkIEoYKetTI5Cn+rhAC1GPk/tTdLIO6JX1
         jkl90EzXhDaPpiHRMlEtVc/WgFNzKmub/JbilhwkDpKBzLw4kOnqKEKkBOm6hNCs9zbl
         9j6g==
X-Received: by 10.194.157.3 with SMTP id wi3mr23611512wjb.30.1452534472973;
        Mon, 11 Jan 2016 09:47:52 -0800 (PST)
Received: from localhost (host143-106-dynamic.248-95-r.retail.telecomitalia.it. [95.248.106.143])
        by smtp.gmail.com with ESMTPSA id w73sm13805161wmw.21.2016.01.11.09.47.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jan 2016 09:47:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqlh7wxc0y.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283682>

On 01/11, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
>
> > On 01/11, Duy Nguyen wrote:
> >> On Sun, Jan 10, 2016 at 9:19 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> >> > Currently when git grep is used outside of a git repository without the
> >> > --no-index option git simply dies.  For convenience, implicitly make git
> >> > grep behave like git grep --no-index when it is called outside of a git
> >> > repository.
> >>
> >> Should we have a line about this behavior in git-grep.txt, maybe the
> >> description section?
> >
> > Yes good point, the behavior change should definitely be documented.
> >
> >> I wonder if anybody wants the old behavior (e.g.
> >> non-zero exit code when running outside a repo). If there is such a
> >> case (*), we may need an option to revert it back (--no-no-index seems
> >> ridiculous, maybe --use-index). The safest way though, is introduce a
> >> new option like --use-index=<always|optional|never> then you can make
> >> an grep alias with --use-index=optional.
> >
> > You're right.  I couldn't think of a reason why someone would rely on
> > the old behavior, but maybe I missed something.  I like the idea of
> > introducing the --use-index=... option.
>
> I don't like that, though ;-)
>
> "We run 'git grep' in random places and relied on it to fail when
> run in somewhere not under control of Git." feels so flawed at
> multiple levels that I doubt it deserves to be kept working.  For
> one thing, "git grep" is not the way to tell something is under
> control of Git (rev-parse would be a better thing for scriptor to
> use).  For another, how would such a script tell between "not a
> git repository" and there was no hits?

I agree that scripts don't deserve to be kept working in that case.
What about a user though who accidentally runs git grep outside of a
repository, and is usually warned by git failing quickly, whereas with
the changed behavior some time might go by until the user realizes the
error.  Not sure if we want to support this use case or not?

> So I do agree that automatic fallback needs to be documented and
> advertised as a feature (or even a bugfix), I do not think we want
> to add knobs to keep such a broken script working.
>
> > How should we handle priority between --no-index and --use-index,
> > should we just give --no-index priority if it is set and ignore the
> > new --use-index option, or is there some other way?
> >
> >> (*) I've been hitting really weird real-world use cases so I'm a bit paranoid..
> >> --
> >> Duy

--
Thomas Gummerer
