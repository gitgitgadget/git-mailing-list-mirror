From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 3/4] stripspace: Implement --count-lines option
Date: Mon, 19 Oct 2015 19:03:34 +0200
Message-ID: <CAP8UFD2pqg_J36V9wZkAR0b-L421gHFi9SbRqFwBbZ1LMVOKSg@mail.gmail.com>
References: <1445008605-16534-1-git-send-email-tklauser@distanz.ch>
	<1445008605-16534-4-git-send-email-tklauser@distanz.ch>
	<CAPig+cQ=8FO8yFY4sHUwr0mYuyvMu4d-eizHZeadE9f0BgpXpQ@mail.gmail.com>
	<xmqqwpukayde.fsf@gitster.mtv.corp.google.com>
	<20151019134633.GL2468@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
To: Tobias Klauser <tklauser@distanz.ch>
X-From: git-owner@vger.kernel.org Mon Oct 19 19:03:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoDqm-0003sT-LZ
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 19:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754410AbbJSRDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 13:03:55 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:36153 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754542AbbJSRDf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 13:03:35 -0400
Received: by lbcao8 with SMTP id ao8so148465942lbc.3
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 10:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=P/g7TxfBIEo8l9JDborLqhAcmJNynhLbeoJ336D4BAk=;
        b=jGovVTwaBCtHT/utp5z5TAZCJMYZtOhWnV6rPbCx3DTWRi/PTLSjgIhrJbzOeOHpA2
         qgRszdIma9NBO3uI0zFDiyQNlXCzkmDcV7mCiORDNHX13pUlnrG/HbYhE0CibfYlI58S
         S5fzwdtnHmmTpghR4821EY/oTS0XnC3HRtpgccVBtp+ibVFSlfluXsIQqsaEH+dDza9P
         DbwepR1KocJPr0Ifpn3aU2xWI7BFW27wogp9WtPE6vSYKTwoVp8p8PEcY5OEryYa7CQW
         7U0Sj9BckBTzvwv3iBhgDfGCYZ220EvbmH45RGHRWrPfiQcCdwY7R6kRVotBJGa4AoVd
         GMbw==
X-Received: by 10.112.218.42 with SMTP id pd10mr15583099lbc.114.1445274214092;
 Mon, 19 Oct 2015 10:03:34 -0700 (PDT)
Received: by 10.25.89.130 with HTTP; Mon, 19 Oct 2015 10:03:34 -0700 (PDT)
In-Reply-To: <20151019134633.GL2468@distanz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279876>

On Mon, Oct 19, 2015 at 3:46 PM, Tobias Klauser <tklauser@distanz.ch> wrote:
> On 2015-10-18 at 19:18:53 +0200, Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>
>> > Is there any application beyond git-rebase--interactive where a
>> > --count-lines options is expected to be useful? It's not obvious from
>> > the commit message that this change is necessarily a win for later
>> > porting of git-rebase--interactive to C since the amount of extra code
>> > and support material added by this patch probably outweighs the amount
>> > of code a C version of git-rebase--interactive would need to count the
>> > lines itself.
>> >
>> > Stated differently, are the two or three instances of piping through
>> > 'wc' in git-rebase--interactive sufficient justification for
>> > introducing extra complexity into git-stripspace and its documentation
>> > and tests?
>>
>> Interesting thought.  When somebody rewrites "rebase -i" in C,
>> nobody needs to count lines in "stripspace" output.  The rewritten
>> "rebase -i" would internally run strbuf_stripspace() and the question
>> becomes what is the best way to let that code find out how many lines
>> the result contains.
>>
>> When viewed from that angle, I agree that "stripspace --count" does
>> not add anything to further the goal of helping "rebase -i" to move
>> to C.  Adding strbuf_count_lines() that counts the number of lines
>> in the given strbuf (if there is no such helper yet; I didn't check),
>> though.
>
> I check before implementing this series and didn't find any helper. I
> also didn't find any other uses of line counting in the code.

This shows that implementing "git stripspace --count-lines" could
indirectly help porting "git rebase -i" to C as you could implement
strbuf_count_lines() for the former and it could then be reused in the
latter.

> After considering your and Eric's reply, I'll drop these patches for
> now and only resubmit patches 1/4 and 2/4 for v3 (also see my reply to
> Eric).

It would be sad in my opinion.

>> >> +test_expect_success '--count-lines with newline only' '
>> >> +       printf "0\n" >expect &&
>> >> +       printf "\n" | git stripspace --count-lines >actual &&
>> >> +       test_cmp expect actual
>> >> +'
>> >
>> > What is the expected behavior when the input is an empty file, a file
>> > with content but no newline, a file with one or more lines but lacking
>> > a newline on the final line? Should these cases be tested, as well?
>>
>> Good point here, too.  If we were to add strbuf_count_lines()
>> helper, whoever adds that function needs to take a possible
>> incomplete line at the end into account.
>
> Yes, makes more sense like this (even though it doesn't correspond to
> what 'wc -l' does).

Tests for "git stripspace --count-lines" would test
strbuf_count_lines() which would also help when porting git rebase -i
to C.
