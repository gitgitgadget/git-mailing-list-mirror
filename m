Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=5.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E3911FE4C
	for <e@80x24.org>; Thu, 16 Jun 2016 21:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbcFPVgR (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 17:36:17 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34420 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755035AbcFPVgO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 17:36:14 -0400
Received: by mail-qk0-f178.google.com with SMTP id s186so67499396qkc.1
        for <git@vger.kernel.org>; Thu, 16 Jun 2016 14:36:13 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6b5xTxYNoqmkH37u4c6JZKpSaAtHn8Oz5uEaV7thcjU=;
        b=JTa7dquXcaS9DOIgFJA0pu6LJNFWN+9Y32qGLU1a4Ed4uN87jrnDBhbAR8unKF2ZNu
         cTch5uQTYezIOVpjSR3gbdc8xyfqy1J/OkjAuz10PSUB+000uXAHBZ5Nwocs1CDPi0Qy
         CsQdNHcLgPb6AS3z/jwha6RS5pVLHmZ6jQ3XCAGyKqTE2ZzglZ2Tz/cjp/0pYtHPGH33
         bWmpcsnG/v+25RjVspPcmtDRNR2pvIUbdtA4KJzCU+7B/71/GGj+O8rr/xrKvvlScFng
         wIvHUy6j5jeM3k8noI1exCLIUhtyHL/VIaZun+6/gqYu3qSqzCnmMqD67AURVVauMsK1
         rIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6b5xTxYNoqmkH37u4c6JZKpSaAtHn8Oz5uEaV7thcjU=;
        b=Zqa9zr3sVgLChOmg4FH0rWFko3ItwfJj5cIT/EoJzkMAPYUX2peHSvFkowCuV68jwR
         oV0L09kkacwQt+8pT5fEG9QpmU6yg9uGrT3fieWq/Aw0JNwATQLkx7d/HOaWpB3MP3DH
         1SNS5Rfydg1SVYM3DJyZ8ZqxB76+HCc6p44XBZbayf41pZCxQfPtiPZWE6ZlaGYX+q3E
         B0RBGhTLJcZHKWAY+VuyC86ntjCldvIRgFe95+JoJGVq49RIqvCV57TYkwAktSgPbnmP
         DaN0ZDmaL+VHamPXBlmnAipb0t4WiSEEAjWaskhM7Lf+z+J6KQISvr2tsEMQctvTGJ6s
         2OMQ==
X-Gm-Message-State: ALyK8tIVjatdmE/FfeL+azNlMZbcjI8s4sPIriRUYPpMGXKxvD5xv2PUj3UaPPIuQVqiysDtlKNIlBnySXUnA/LI
X-Received: by 10.200.39.142 with SMTP id w14mr7662205qtw.59.1466112973152;
 Thu, 16 Jun 2016 14:36:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.42.226 with HTTP; Thu, 16 Jun 2016 14:36:12 -0700 (PDT)
In-Reply-To: <576315E1.2050405@alum.mit.edu>
References: <20160616174620.1011-1-sbeller@google.com> <576315E1.2050405@alum.mit.edu>
From:	Stefan Beller <sbeller@google.com>
Date:	Thu, 16 Jun 2016 14:36:12 -0700
Message-ID: <CAGZ79kbr03yVT3SZXZTpE=Pdh11Ge5TP3LF_7r9_wP=CZM3SXg@mail.gmail.com>
Subject: Re: [PATCH] diff compaction heuristic: favor shortest neighboring
 blank lines
To:	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

>
> The heuristic I proposed was
>
> * Prefer to start and end hunks *following* lines with the least
>   indentation.
>
> * Define the "indentation" of a blank line to be the indentation of
>   the previous non-blank line minus epsilon.
>
> * In the case of a tie, prefer to slide the hunk down as far as
>   possible.
>
> If that's what you are trying to implement, then notice that the first
> rule says that the hunk should start *following* the line with the least
> indentation. So the "score" for

I did not try to implement that heuristic.

> * Prefer to start and end hunks *following* lines with the least
>   indentation.

We had this alone as a heuristic and it turned out badly. (More
false positives than the current "empty line only" thing)

It may however be a good starting block when combined with the other
conditions, as blank lines are assigned a longer virtual length than
what they have.

> * In the case of a tie, prefer to slide the hunk down as far as
>   possible.
>

This is what the current implementation does as well. (i.e. if there is
more than one blank line, we have a tie, so choose the last one as the
end of the hunk)


So what I am proposing in this patch:

 * Prefer to start and end hunks *following* lines with an empty line.
   (as implemented currently)

 * In the case of a tie, make use of a second tier heuristic.

 * Define the "length" of a blank line to be the
    minimum of the amount of white space in the line before and after

 * Choose that empty line (first tier) that has the shortest length
(second tier)

 * In the case of a tie, prefer to slide the hunk down as far as
   possible.

I would be really interested how these two heuristics compare in practice.

>
>> +        end
>> +
>> +        def bal
>
> would be the indentation of the line preceding "end", which is larger
> than the indentation of "end". And the score for
>
>> +                do_bal_stuff()
>> +
>> +                common_ending()
>
> would come from the line preceding "do_bal_stuff()", namely "def bal()",
> which is indented the same as "end". So the latter would be preferred.
>
> But actually, I don't understand how your example is meaningful. I think
> this heuristic is only used to slide hunks around; i.e., when the line
> following the hunk is the same as the first lines of the hunk, or when
> the line preceding the hunk is the same as the last line of the hunk.

Right.

> Right? So your snippets would never compete against each other.

right, I was using that to show why some parts are more favorable to
put a break in (i.e. the transisiton from "+ lines" to surrounding lines.
I was not clear enough there. :(

> Let's
> take the full example. The five possible placements for the `+`
> characters are marked with the digits 1 through 5 here:
>
>>              def bar
>>                      do_bar_stuff()
>> 1
>> 12                   common_ending()
>> 123          end
>> 1234
>> 12345        def bal
>> 12345                do_bal_stuff()
>>  2345
>>   345                common_ending()
>>    45        end
>>     5
>>              def baz
>>                      do_baz_stuff()
>>
>>                      common_ending()
>>              end
>
> Of the lines preceding the candidate hunks, the blank line preceding the
> hunk marked "5" has the smallest indent, namely "epsilon" less than the
> indentation of the "end" line preceding it. So placement "5" would be
> chosen.

I agree 5 is the best here, but for other reasons.

Imagine /s/end/long final boilerplate code/, and it may be more clear.
What I am trying to say is, that you "indentation" of the blank line is not
reaching until the end of the "end" line, but rather to the front of "end".

(If you don't care of white spaces in the git history and have an editor, that
makes fancy white space stuff, i.e. your text editor cursor is in the "end" line
and you press "enter" to get to the next line, it is most likely indented to
strlen ("<end line>") - strlen("end"), as that is how much indentation we had
in the preceding line?

>
> I don't know enough about this area of the code to review your patch in
> detail, but I did note below a typo that jumped out at me.

I did not know the code either before writing the patch. :)


>> +                                     if (min_bl_neigh_indent > bl_neigh_indent)
>> +                                             min_bl_neigh_indent = min_bl_neigh_indent;
>
> The line above has no effect (same variable on both sides of the =).

Thanks!

I had the feeling something was off judging from behavior,
but could not tell what exactly. This is it.

It should be

    min_bl_neigh_indent = bl_neigh_indent;

i.e. the minimum of the existing and newly computed surrounding line
starting blanks.

Junio writes:
> Now, on what column does 'd' sit on the example below?
>
>        def foo
>
> I typed SP SP HT 'd' 'e' 'f'; it still is indented by 8 places.

I see, so for the TAB case we would need to do a

    ret += (8 - ret%8);

Thanks!
Stefan
