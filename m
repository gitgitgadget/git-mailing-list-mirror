From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v12 03/13] ref-filter: introduce the ref_formatting_state stack machinery
Date: Thu, 20 Aug 2015 09:51:24 -0700
Message-ID: <xmqqr3mx7vjn.fsf@gitster.dls.corp.google.com>
References: <1439923052-7373-1-git-send-email-Karthik.188@gmail.com>
	<1439923052-7373-4-git-send-email-Karthik.188@gmail.com>
	<vpqvbcb2uoi.fsf@anie.imag.fr>
	<xmqq37zf9klg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Aug 20 18:51:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZST3s-00059B-Qh
	for gcvg-git-2@plane.gmane.org; Thu, 20 Aug 2015 18:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752970AbbHTQv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2015 12:51:27 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35696 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753224AbbHTQv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2015 12:51:26 -0400
Received: by pacdd16 with SMTP id dd16so23594679pac.2
        for <git@vger.kernel.org>; Thu, 20 Aug 2015 09:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=UrX498jbqk0FGoax+uXSfa59eBIYMPJkd6krNCrQ/2Q=;
        b=Z/VcZqagFZdyJ5mYxZqI7rZKHBSwsjzDLCuAFUKDYf1/wO8QOhXytdNLxfZ6hBflhc
         k7S+wbXg7eOsNlMnO8PN5iFdsp9YlOONsiqh7C+wWeIGz+HgZ0WYqJKSjuCzgOsdTDPA
         jUCSVJSyPmLn5RKLbP2MG/VvRm5l0hk122LGtW8EZrJt6iPvU4BYIZgbRTVlTXNDx9/g
         mw5KAoRul8PXA2ohj0y1amRtuZMj0w45RKIukWPsSv+BefmXPEo3WWpDMHOYD7TY7OD0
         iDluR7ygH1uul/KPY5pEXXEheXMXZWT/w3W8A0uCIjsyfSvjY2FY+M4pIS3Jqk/9TAlV
         Hzrw==
X-Received: by 10.68.95.225 with SMTP id dn1mr8091082pbb.128.1440089485863;
        Thu, 20 Aug 2015 09:51:25 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:247b:3165:9cce:44a3])
        by smtp.gmail.com with ESMTPSA id ya3sm4913372pbb.71.2015.08.20.09.51.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 20 Aug 2015 09:51:24 -0700 (PDT)
In-Reply-To: <xmqq37zf9klg.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 19 Aug 2015 11:52:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276252>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> You replaced the quote_style argument with ref_formatting_state, and I
>> think you should have kept this argument and added ref_formatting_state.
>> The other option is to add an extra indirection like
>>
>> struct ref_formatting_state {
>> 	int quote_style;
>> 	struct ref_formatting_stack *stack;
>> }
>>
>> (ref_formatting_stack would be what you currently call
>> ref_formatting_state). But that's probably overkill.
>
> I think this is the right way to go.  As you explained in your later
> messages, this is conceptually a global setting that applies to
> anybody working in the callchain and not something individual
> recursion levels would want to muck with.

The fact that this is conceptually a global setting does not change,
but I think the deeper levels should not care or even _know_ that
language-specific quoting rules exist (see other post).

Sorry for the confusion.
