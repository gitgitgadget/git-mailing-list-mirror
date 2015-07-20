From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 1/9] ref-filter: add option to align atoms to the left
Date: Mon, 20 Jul 2015 22:34:27 +0530
Message-ID: <CAOLa=ZT7szz=cwzEmVDPKucRbh2o_8mBhUY22=R8qCU34QPwGg@mail.gmail.com>
References: <1437246749-14423-1-git-send-email-Karthik.188@gmail.com>
 <1437246749-14423-2-git-send-email-Karthik.188@gmail.com> <xmqq1tg2zsxr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 20 19:05:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHEUw-0004fX-8f
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 19:05:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754232AbbGTRE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 13:04:58 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:33911 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884AbbGTRE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2015 13:04:57 -0400
Received: by obre1 with SMTP id e1so105740725obr.1
        for <git@vger.kernel.org>; Mon, 20 Jul 2015 10:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0w8089rHqlKHCLhfVuz3i/CUIHtvDa6TixlBxD3bo2c=;
        b=uz+Qb8cHFkAOkZ7nJ8Q7EkLtC5jcLRH9ImIWSFoX84w/SBpbAoAWjmAa30MPFX3lbx
         wzu2BezVIqdyr8BugYRzOhvhWZkWY8fZNtADOTa5kx1Dw5NBsE5BwnmHDoDqXCi4nk8Q
         tgG5Vkc5kxPRT0ZGTtzftxLPgllNKTpe6aYXtElfz/IVWVFCtbxxgEorxNSmimuwWAf0
         b63LFlLwa/dCbfSflKklWjR1HyN10Xfua74Uq8IkyLns05aOAyHk5Rt0tzgsnfxTluad
         roUOZssVwv0HEyb6InV1Z27fH039fOdrtv2J4DlAl/RRlzT4HethyM4+Qouxky/SgDWs
         334w==
X-Received: by 10.202.92.6 with SMTP id q6mr25910390oib.11.1437411896632; Mon,
 20 Jul 2015 10:04:56 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Mon, 20 Jul 2015 10:04:27 -0700 (PDT)
In-Reply-To: <xmqq1tg2zsxr.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274331>

>
> What is your plan for this function?  Is it envisioned that this
> will gain more variations of formatting options over time?
> Otherwise it seems misnamed (it is not "assign formatting" but
> merely "pad to the right").
>

I wanna include an 'ifexists' atom in the future where an user can
specify a string format to be printed only if the preceding atom holds
a value.
e.g. '%(ifexists:refname is %s)%(refname)'
So I see that going in here.

> I also doubt that the logic is sane.  More specifically, what does
> that "if (v->s[0])" buy you?

Yeah, that's wrong, like Eric pointed out. Should have been
"if (v->s[0] == '\0')"

>
> Your caller is iterating over the elements in a format string,
> e.g. 'A %(align:20)%(foo) B %(bar) C', and its caller is iterating
> over a list of refs, e.g. 'maint', 'master' branches.  With that
> format string, as long as %(foo) does not expand to something that
> exceeds 20 display places or so, I'd expect literal 'B' for all refs
> to align, but I do not think this code gives me that; what happens
> if '%(foo)' happens to be an empty string for 'maint' but is a
> string, say 'x', for 'master'?

Oh yeah! That doesn't work, I have a fix in mind I'll reply to this
mail with a fix.

-- 
Regards,
Karthik Nayak
