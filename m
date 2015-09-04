From: Josh Rabinowitz <joshr@joshr.com>
Subject: Re: [PATCH] push: don't show Done with --quiet --porcelain
Date: Fri, 4 Sep 2015 09:11:01 -0400
Message-ID: <CA+WR+g7V0Rez_oug5P_LDmafQKXqnDHDNN_vk=-1Sbj3-754DQ@mail.gmail.com>
References: <CA+WR+g7frN4uV12dxahxZbr-5az7sj3zx2oN-Z3rKH0_Y8jqqg@mail.gmail.com>
 <xmqqvbburrkf.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, "Larry D'Anna" <larry@elder-gods.org>,
	Tay Ray Chuan <rctay89@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 15:11:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXqmA-0001bu-L9
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 15:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759080AbbIDNLX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 09:11:23 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:35382 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758864AbbIDNLV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 09:11:21 -0400
Received: by ioiz6 with SMTP id z6so22892197ioi.2
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 06:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=QGQxba50STW0ff5/xwIcdOuRIrzgVjOvTNRQwKfq3NU=;
        b=lJQ+TXknGiL5A/sNl7cPm1OIcH2KtBy6e5W8A3NoDI5izxaH1iOUG58b6WcUBVW7Q0
         0x/VI2MPcJojDlOxE9+l1mjwMsEafxpAjuUjDSa9R+qUWRndJsObkMitVX3xpLKwmuc/
         Z18/qbqfuv80v7Kx9yAN+GmjtVu4RuStuh3yYc6wcor6LP04KEDInE7OMarns4x2VZ0K
         DuUNp4/vqrNZpJtyxxngpHv2aiup8eeaIhithLQs5GWISRvphPzzfGC/b6U582SywEfM
         VZQ4GQr5hKJLZVd5qsqeo7XwowHleIJKBd36aQ+qe/b2AgYdUpcxS+xCHc3T0SJPKGGV
         Bp7g==
X-Received: by 10.107.47.193 with SMTP id v62mr6940728iov.13.1441372281234;
 Fri, 04 Sep 2015 06:11:21 -0700 (PDT)
Received: by 10.64.122.2 with HTTP; Fri, 4 Sep 2015 06:11:01 -0700 (PDT)
In-Reply-To: <xmqqvbburrkf.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: m5jYsduXQFLBkaaTt8RogcgQhjg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277306>

Hi Junio and other recipients:

Junio, thanks for your response. I think you may have misunderstood my
patch though (or I am misunderstanding your responses), because it
seems we are actually in agreement.

1) My original patch is to make 'git push --porcelain --quiet' not
emit 'Done' when there is no error. It would continue to emit "Done"
when using 'git push --porcelain' without an error.

2) In your first paragraph, you seem to state that while printing
"Done" is advantageous when using 'git push --porcelain' without
--quiet, the "Done" output isn't needed when --quiet is used. This
appears to agree with my patch's intent.

3) in your second paragraph, you seem to agree with me again, that
"Done" is not needed when "git push --porcelain --quiet" is use

4) Then in your third paragraph, you say that you don't want to remove
the "Done" output when using "git push --porcelain" without --quiet --
which my patch preserves (again, it would only remove the "Done" text
when 'git push --porcelain' is used with --quiet and there is no
error.)

In summary, I think we are in agreement that this patch is probably
acceptable. Look forward to reading comments.

Best,
 Josh Rabinowitz



On Tue, Sep 1, 2015 at 1:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Josh Rabinowitz <joshr@joshr.com> writes:
>
>> Change so 'git push --porcelain --quiet' emits no text when there
>> is no error.  This makes the --quiet option here more consistent with
>> other git commands.
>>
>> Signed-off-by: josh rabinowitz <joshr@joshr.com>
>> ---
>
> The rationale given in 77555854 (git-push: make git push --porcelain
> print "Done", 2010-02-26) does not apply when "--quiet" is in use,
> because we do give the rejection notice to the standard output even
> under "--quiet", so the calling script can tell between the case
> where we couldn't reach the remote side (i.e. no rejection notice)
> and the case where we reached them and they rejected (i.e. they will
> tell us why the push was rejected) when "git push" reports a failure
> with its exit status.
>
> For that matter, I am not sure if this "Done" introduced by 77555854
> is really needed even when "--quiet" is not in effect.
>
> In either case, saying "Done" after talking to the remote end
> already is an established part of the output meant for Porcelain
> when "--porcelain" option is in use.  So I do not think changing it
> is a good idea.  Existing scripts that read from "--porcelain" output
> would be expecting the line to be there.
>
>>  transport.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/transport.c b/transport.c
>> index 40692f8..0021b3f 100644
>> --- a/transport.c
>> +++ b/transport.c
>> @@ -1209,7 +1209,7 @@ int transport_push(struct transport *transport,
>>                 transport_update_tracking_ref(transport->remote, ref, verbose);
>>         }
>>
>> -       if (porcelain && !push_ret)
>> +       if (!quiet && porcelain && !push_ret)
>>             puts("Done");
>>         else if (!quiet && !ret && !transport_refs_pushed(remote_refs))
>>             fprintf(stderr, "Everything up-to-date\n");
>> --
>> 2.3.2 (Apple Git-55)
