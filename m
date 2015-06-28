From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10.1 7/7] bisect: allow any terms set by user
Date: Sun, 28 Jun 2015 11:51:55 -0700
Message-ID: <xmqqh9prekdw.fsf@gitster.dls.corp.google.com>
References: <xmqqsi9etjwy.fsf@gitster.dls.corp.google.com>
	<1435351183-27100-1-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqa8vmrtsh.fsf@gitster.dls.corp.google.com>
	<CAP8UFD1PyS_qM3EHW_Nzmo=3aeTDkZ0M3hnhRQANAO+ShF3H1Q@mail.gmail.com>
	<CAPc5daXSnovQPxR5kVoeRy4kApH7DiuTDvAz1ooQFp=5DZZg4Q@mail.gmail.com>
	<558F8B55.1070708@alum.mit.edu>
	<CAPc5daWmhkqDL0pNYne4-kRoxWK7ObcOKxtE5DsfHA2cnMM1pQ@mail.gmail.com>
	<558F9854.5080605@alum.mit.edu>
	<xmqqwpyoe1aj.fsf@gitster.dls.corp.google.com>
	<558FDAF9.3010300@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git <git@vger.kernel.org>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Jun 28 20:52:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9HgS-0006Sh-Tv
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 20:52:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752666AbbF1Sv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 14:51:59 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:33795 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576AbbF1Sv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 14:51:58 -0400
Received: by iebmu5 with SMTP id mu5so102648135ieb.1
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 11:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=0rSlvKlAocMxlXLG00Dq5iQ9nzWQL559A+K0CXeboOM=;
        b=pPnZewi4LdpeIHOCy99CtNDm50EiigDI64hGzx8B5FrUY0UDmAY1ac2H8RMGd7pCT3
         0fCoR0lAq3k4RzcuhAnwZfzm2ucfjcpYLKTOEX9MgXEixze4Kxbz5sfr1gpY7as+77ql
         eEIvbP70oJePdmXyi097+IBJ9k0USOggxWa5+tv/DW7ms90ZPA/4fJUhiwpar5aIceJ/
         AUaZCUOOm3nBhvZ3HRAkKfg5C3VFlhFxo7y4xmpY7Qp3x6XVd7shgHKKDDERSR7pYeMe
         PaHOvrPPbzCX/Ns4xp8CdHjXW+VXq9U0sbZsw/NHQIGZyqvojYg7g7FfjOUa+ESGl1HH
         o62g==
X-Received: by 10.107.47.26 with SMTP id j26mr15650948ioo.17.1435517517971;
        Sun, 28 Jun 2015 11:51:57 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a109:3c27:ff77:e0c7])
        by mx.google.com with ESMTPSA id s28sm24632791ioi.31.2015.06.28.11.51.56
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 28 Jun 2015 11:51:56 -0700 (PDT)
In-Reply-To: <558FDAF9.3010300@alum.mit.edu> (Michael Haggerty's message of
	"Sun, 28 Jun 2015 13:31:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272924>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 06/28/2015 09:32 AM, Junio C Hamano wrote:
>> 
>> You just _always_ say "good" or "bad".  If something is slow, you
>> say "bad" and if something is fast, you say "good".
>
> Yes, I think "good" and "bad" would usually be perfectly intuitive and
> would almost always be usable.
>
>> [...]
>> No need for "bisect new", "bisect old", or "bisect terms", let alone
>> "bisect terms --new=fast --old=slow".  The tool just does the right
>> thing because it already has the information necessary to infer what
>> the user means by 'good' and 'bad', and the initial topology determines
>> which transition, either from 'good' to 'bad' or from 'bad' to 'good',
>> the user is hunting for.
>
> Correct. The only caveat is if the initial "good" and "bad" commits are
> not ancestrally related to each other. But in this case, I think
> "bisect" asks the user to test a merge base anyway, and once that one
> has been tested it will be clear which of the labels comes "before" the
> other.

The more I look at the proposal, the more I like it.  The old way of
thinking is that we need to keep 'bad' for newer one and 'good' for
older one, that required us to invent 'broken' vs 'fixed', or value
neutral 'old' vs 'new'.  Then we extend it to a random pair of
'terms', but we reserve 'good', 'bad', etc. and do not allow the
user to say "old was bad, new is now good".  With your proposal, the
user can just say "oh this is good", vs "oh this is bad".  The
mental model becomes much simpler.

I _think_ bulk of Antoine and Matthieu's work can be salvaged/reused
to implement the proposal, but now it would be more clear that
$name_good and $name_bad is a bad way to name internal variables and
files in $GIT_DIR.  The inferred 'ah you are hunting for regression'
mode would call old ones 'bad' and new ones 'good', they have to be
given value neutral names, e.g. $name_old and $name_new.
