From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v8 4/4] t1006: add tests for git cat-file --literally
Date: Sat, 18 Apr 2015 10:52:57 +0530
Message-ID: <5531EA31.1010104@gmail.com>
References: <552E9816.6040502@gmail.com> <1429117232-5102-1-git-send-email-karthik.188@gmail.com> <CAPig+cRoY5OEvoZ4oysdiDTpMh+mYgL3dYAOYOhnRgH_=a1fzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Apr 18 07:23:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjLDi-0006Wl-Vp
	for gcvg-git-2@plane.gmane.org; Sat, 18 Apr 2015 07:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbbDRFXD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2015 01:23:03 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:33600 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbbDRFXC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2015 01:23:02 -0400
Received: by pdbnk13 with SMTP id nk13so148709688pdb.0
        for <git@vger.kernel.org>; Fri, 17 Apr 2015 22:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=k/C+ImZjNxbiB7EjPLrdksGHX1tXHRmXK1YupyRQSpw=;
        b=q1l5CPsNoFmMhSmREgg/NXqH8NBwoUN48qK7nzeP8r0JXQxjz1srmN7qWv3MwCPygh
         7A7wRYC4v+ONmbFWjDBEwp++1pIsEj9Kd/P9RqLLsgaocYt8j0ND58pvSxzrgOQocatV
         UiA/zTAgSdVgTS1S+/YAiJcuI7QmgVltgYb70bL0w48eLQQ9fBcMBRID975LeklnvV2S
         U4JMr+xFgd5ILQ0Igawo0kE97GPIal7xLwuBtoiTvFvDgJSIh4BtT7OVkMcFmDqneKHM
         D8wz0d6ENEN9SqKgS+3lLYX3XmU1cCN45MZTzbSZ4ookr60Q1wScTy3QoJq29FDBbCwv
         d92w==
X-Received: by 10.66.231.42 with SMTP id td10mr10994853pac.98.1429334581749;
        Fri, 17 Apr 2015 22:23:01 -0700 (PDT)
Received: from [192.168.0.100] ([103.227.98.178])
        by mx.google.com with ESMTPSA id ul8sm11768370pab.36.2015.04.17.22.22.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Apr 2015 22:23:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <CAPig+cRoY5OEvoZ4oysdiDTpMh+mYgL3dYAOYOhnRgH_=a1fzQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267406>


On 04/18/2015 05:30 AM, Eric Sunshine wrote:
> On Wed, Apr 15, 2015 at 1:00 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> > Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> > ---
> > diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> > index ab36b1e..61fab78 100755
> > --- a/t/t1006-cat-file.sh
> > +++ b/t/t1006-cat-file.sh
> > @@ -296,4 +308,21 @@ test_expect_success '%(deltabase) reports packed delta bases' '
> >          }
> >   '
> >
> > +bogus_type="bogus"
> > +bogus_content="bogus"
> > +bogus_size=$(strlen $bogus_content)
>
> If someone ever changes the value of 'bogus_content' so it contains
> whitespace, then the result of strlen() will be incorrect as you've
> invoked it. You should quote its argument (as other callers in this
> script do) to safeguard against such an issue.
>
>      bogus_size=$(strlen "$bogus_content")
>
> > +bogus_sha1=$(printf $bogus_content | git hash-object -t $bogus_type --literally -w --stdin)
>
> Ditto regarding quoting of 'bogus_content'.
>
> Also, if someone ever modifies 'bogus_content' so that it contains a
> literal '%' (such as "%s"), then your printf() invocation will
> misbehave. Either call it like this:
>
>      $(printf '%s' "$bogus_content" | ...)
>
> or, better yet, call echo_without_newline() as other similar code
> elsewhere in this script does, and as suggested earlier[1].
>
> [1]: http://article.gmane.org/gmane.comp.version-control.git/266972/
>
> > +test_expect_success "Type of broken object is correct" '
> > +       echo $bogus_type >expect &&
> > +       git cat-file -t --literally $bogus_sha1 >actual &&
> > +       test_cmp expect actual
> > +'
> > +
> > +test_expect_success "Size of broken object is correct" '
> > +    echo $bogus_size >expect &&
>
> Bad indentation. Use tab rather than spaces.
>
> > +       git cat-file -s --literally $bogus_sha1 >actual &&
> > +       test_cmp expect actual
> > +'
> > +
> >   test_done
> > --
> > 2.4.0.rc1.249.gb598846
Thanks Eric for the changes. I did "echo -n" at the beginning but that
gave me a warning and asked me to use printf instead. I'll use
echo_without_newline, Thanks.
