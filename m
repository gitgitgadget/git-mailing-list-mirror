From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] diffcore-pickaxe doc: document -S and -G properly
Date: Wed, 15 May 2013 01:16:01 +0530
Message-ID: <CALkWK0=U8hySDc=OhQu6PjDNJ_fk3UBW8tmNowntghHS2-VbmQ@mail.gmail.com>
References: <1368540759-25598-1-git-send-email-artagnon@gmail.com>
 <CABURp0r808KeSRwhgPw98vUC+JSErvSYHFyAvn-=8JhQzn8e1Q@mail.gmail.com>
 <CALkWK0nR1=Pgv0AY78p7n17C-VVvbc6BfJ4y_Df1ciZoc-xR-Q@mail.gmail.com> <7vppwtid3n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Phil Hord <phil.hord@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 14 21:46:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcLBP-0008BR-5k
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 21:46:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758404Ab3ENTqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 15:46:43 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:44459 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758111Ab3ENTqm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 15:46:42 -0400
Received: by mail-ie0-f169.google.com with SMTP id u16so2011699iet.0
        for <git@vger.kernel.org>; Tue, 14 May 2013 12:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ryB3ujYHxzK3EluXC8pB7IhFi/3jGAwSpbDQQXZq2bM=;
        b=o201gL75+CMJrz3Jy1b/W3NNKkAn0869L8vV8kkHF42mQ3T4kymQhIYNPMbkSrl5lr
         s/iI12L1yOu/1HeU8AA51F6vJC0aHRAjFzVFkZWI+wWa95MkCXrspB4d+qGD2FF5UMQf
         NcXrTR9G8jRLv5gcZsgTqt6bbcuh7r+dCo2UMl9GfO+R+AWeO/1otFERH1bLTpGNDoYe
         rT6sdz+plJreOFI5PdnWTfavE78gh4sn9d6NhPsZio6lz9uQHGaA8sQh80GicxAoiIw1
         GbnQOHoV677avYKdQuWyapNykuwZdIf67tRdnk0dQF5SC2/UcI2bmlVQO48SKRrwKY+G
         VyXg==
X-Received: by 10.50.73.65 with SMTP id j1mr3318245igv.49.1368560802132; Tue,
 14 May 2013 12:46:42 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Tue, 14 May 2013 12:46:01 -0700 (PDT)
In-Reply-To: <7vppwtid3n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224326>

Junio C Hamano wrote:
> I think what makes this paragraph unnecessarily hard to read is the
> "While rename works".
>
> With that, you are implying "if you rename a file as a whole without
> changing the block of text you identify with the -S parameter, then
> such a change is not interesting as far as pickaxe is concerned".
> while that statement is logically correct, normal people are not
> that generous to read that much between your lines.

Yes, I'm exactly implying that.  But I don't want to lose meaning: in
the previous sentence, I talk about filepairs.  I want to point out
that rename detection working at the filepair level is a perfectly
normal thing.

> I think that is one of the reasons why "If you moved a string from
> file A to file B, log -S will flag that change as worth inspecting"
> does not seem to logically follow and made Phil find your
> description confusing.

Sure, we can elaborate a bit more.

> Finding such a change indeed is a feature [*1*]; we need to flag
> such a change as worth inspecting to find where the code came from
> in order to dig deeper, so at least this "cannot omit" should be
> "does not omit".

What I was trying to say is that it's an accidental feature: the
reason this "feature" exists is because diffcore is tied to filepairs
(and rename detection works at the filepair level).  You may argue
that there's nothing wrong with this design, but consider what happens
if you rebase on top of a big code move: it's completely broken.  If
git were a true content tracker, and file boundaries really did not
matter, isn't this feature actually a deficiency?

Ofcourse, the user doesn't need to know all this, and "does not omit"
is a good suggestion.
