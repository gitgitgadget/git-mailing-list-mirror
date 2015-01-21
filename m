From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 3/6] refs.c: replace write_str_in_full by write_in_full
Date: Wed, 21 Jan 2015 15:44:36 -0800
Message-ID: <CAGZ79kaTUraVYc1Th0-8ajw4kMuU-Sir2e9dW1uy90CuQRzgeg@mail.gmail.com>
References: <1421882625-916-1-git-send-email-sbeller@google.com>
	<1421882625-916-4-git-send-email-sbeller@google.com>
	<20150121233843.GB11115@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Loic Dachary <loic@dachary.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 22 00:44:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE4wz-0005yL-Tl
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 00:44:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752891AbbAUXoi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 18:44:38 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:60127 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510AbbAUXoh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 18:44:37 -0500
Received: by mail-ie0-f172.google.com with SMTP id rd18so16148652iec.3
        for <git@vger.kernel.org>; Wed, 21 Jan 2015 15:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4w+Pqe5lbaqEl4kb6vlRn0gcPNc8/5cGUEnv3tV5TXo=;
        b=mirDqKk6YKe1lqGQEaZhWcXiiTfYN30osuUs3taFf7euvW4mDnUMYItqdFJgo2KiiE
         J+LqeVXvReC9LWwsXyAIf/CyJQSi5RB1i7A96lsgJ71aeLgjjcOBigIJ+79BRVKA1rJr
         78q6S5X7PBJajhliQ/NnkcNY3avnCwLM5IyV3APQ5P6CcHh3uzf5VOHVSheZXHQuphHq
         SSQvuMcZYgfiKP0mCK20jH9TObuezTNwdfBXE7m3J5h8ThuatVM97oezQLdYmNCZd6V9
         4fQmFP2ech3Q6AscKFA4BtezfEU1sXvhnHwa46trXH7cVfJqWjMjfe5KoT5PdIDAFJbX
         KKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=4w+Pqe5lbaqEl4kb6vlRn0gcPNc8/5cGUEnv3tV5TXo=;
        b=GajBRJA6bt5xQN0JoykQYNuxnL02Rm2mbbvbQmLD9cLobcw5iO6nq7LchwFzpHRGk0
         7xOnSCSCeNMumB6JFpHxK0jqWEy7iaWhBp6TF+2YvTitgkhUtvLfnOVseAbUm+oJX0B6
         HTMC4GxfzudtUgNE024KfvYHrsPw4DPXfDUpqlphin2SwgMkQoFHcMrlvEcuwVLO2E/Q
         Yh7H1+UjU0BjIS5GmXsxLmqjOXGzfp4Z6K3nJZpHQSHPsn8TLy2iKJP5yyBWiBkOLuqC
         zHNMLxrEInkZJATbxaH6ydHVB/Zq9N6jVhNn6uJOESl8Pibo+EOz0YLG3BjiQGekgI67
         veJQ==
X-Gm-Message-State: ALoCoQmHxOGLLgoCXT6PrIZyqlY64G0IdT6/AiriqCHIDyr8IeaJy6vCowSZN3Idm5VaOottsK/K
X-Received: by 10.50.79.196 with SMTP id l4mr8286544igx.14.1421883876413; Wed,
 21 Jan 2015 15:44:36 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Wed, 21 Jan 2015 15:44:36 -0800 (PST)
In-Reply-To: <20150121233843.GB11115@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262787>

On Wed, Jan 21, 2015 at 3:38 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Jan 21, 2015 at 03:23:42PM -0800, Stefan Beller wrote:
>
>> There is another occurrence where we could have used write_str_in_full
>> (line 3107: write_in_full(lock->lk->fd, &term, 1)), so the current state
>> is inconsistent. This replaces the only occurrence of write_str_in_full
>> by write_in_full, so we only need to wrap write_in_full in the next patch.
>
> I had to read the first sentence a few times to figure out what you
> meant. But I am not sure it is even relevant. We do not care about the
> inconsistency.

You're not the first who needs to reread my stuff :/
I have the impression my English worsened since coming into the USA.

We do not care about the inconsistency, but we may care about the change itself:
"write_str_in_full is way better than write_in_full, so why the step backwards?"
And  I am trying to explain that this is not a huge step backwards but
rather improves
consistency.

> It is just "we are about to change how callers of
> write_in_full in this file behave, the wrapper gets in the way, and it
> does not add enough value by itself to merit making our future changes
> in two places".

That's actually true. Though that sounds as if we'd be lazy ("we only
want to make
one change, so let's bend over here")

I'll rethink the commit message.
Thanks,
Stefan
