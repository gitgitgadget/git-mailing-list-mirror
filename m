From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 5.5/22] Add documentation for the index api
Date: Thu, 11 Jul 2013 18:42:06 +0700
Message-ID: <CACsJy8DNQ5Sr4a7PZMX4G-pf+fHqR398b3mncCZtQ-BBBpD+RQ@mail.gmail.com>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
 <1373184720-29767-6-git-send-email-t.gummerer@gmail.com> <CACsJy8C0F+v3g+gPon6Y8+z7ObN1Jv8Ln==RNrVsRp7aya74hw@mail.gmail.com>
 <87pputqowr.fsf@gmail.com> <CACsJy8CtOWjpxKuNhQXYjPAv8MU0U6yTBEuQeqm0kxqVne6NjQ@mail.gmail.com>
 <871u78rcw0.fsf@gmail.com> <CACsJy8A9+1O_em=FtV_TUKags4FrSggV76dd1h6gsJ+JHfjZKw@mail.gmail.com>
 <87wqozpk9s.fsf@gmail.com> <CACsJy8BRw6jqB1XBzDcCr3UXNGG1wRPjwnMrh+EksFf7VsQysg@mail.gmail.com>
 <87ppupcp19.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 11 13:42:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxFGo-00059V-0F
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 13:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755523Ab3GKLmj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 07:42:39 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:64227 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778Ab3GKLmh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 07:42:37 -0400
Received: by mail-ob0-f173.google.com with SMTP id wc20so9763368obb.18
        for <git@vger.kernel.org>; Thu, 11 Jul 2013 04:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=aGxgqB21laO+aU72TwL4qPPccCW1io7vrsmpdC7/mu8=;
        b=YVKu77ScTU7fxWnHmgIfHgSSPzuNy0ZMYNEvlqRXAE0+nbR1VOu3ZMq19NdL065JHA
         pyBSHEzUt38rI0MoAhbEohwNuwOKIIiUPMoWrYWxp7f3cdjqp2sVEEQAUZ7QSfQWojqA
         Q1YAN0YfdbIHTCgjgxf2h5/wPaQK3AJQJj3CrJB4Z3NGqcU82vfeGZORBu191VseemPw
         uMbLxiAyF4ltoX79iWxxkIH8LLm7pB/xjgyFLm22wg4ARSHbnkBYi9lQN5/sw3qq9wMu
         pv7qVejfNwmyjaWAHino1KPwAYwIeimgLxL8LLLzH8GesFzFqAv3gMJpDn0gK1QJS1qZ
         KqxQ==
X-Received: by 10.60.54.232 with SMTP id m8mr31375284oep.35.1373542956967;
 Thu, 11 Jul 2013 04:42:36 -0700 (PDT)
Received: by 10.76.88.230 with HTTP; Thu, 11 Jul 2013 04:42:06 -0700 (PDT)
In-Reply-To: <87ppupcp19.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230093>

On Thu, Jul 11, 2013 at 6:30 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Wed, Jul 10, 2013 at 3:10 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>>>> If you happen to know that certain entries match the given pathspec,
>>>> you could help the caller avoid match_pathspec'ing again by set a bit
>>>> in ce_flags.
>>>
>>> I currently don't know which entries do match the pathspec from just
>>> reading the index file, additional calls would be needed.  I don't think
>>> that would be worth the overhead.
>>
>> Yeah I now see that you select what to load in v5 with the adjusted
>> pathspec, not the input pathspec. Originally I thought you match the
>> input pathspec against every file entry in the index :P Your adjusted
>> pathspec looks like what common_prefix is for. It's cheaper than
>> creating adjusted_pathspec from match_pathspec and reduces loading in
>> major cases, where glob is not used.
>>
>> Still, creating an adjusted pathspec this way looks iffy. You need to
>> understand pathspec in order to strip the filename part out to match
>> the directory match only. An alternative is use
>> tree_entry_interesting. It goes along well with tree traversal and can
>> be used to match directories with original pathspec. Once you see it
>> matches an entry in a directory, you could skip matching the rest of
>> the files and load the whole directory. read_index_filtered_v5 and
>> read_entries may need some tweaking though. I'll try it and post a
>> patch later if I succeed.
>
> Hrm, I played around a bit with this idea, but I couldn't figure out how
> to make it work.  For it to work we would still have to load some
> entries in a directory at least?  Or is there a way to match the
> directories, which I just haven't figured out yet?

Yes you have to load some entries first. Even if a directory does not
match, we only know until at least the first file in the directory. OK
there might be problems because tree_entry_interesting expects all
entries in a directory to be memcmp sorted, without trailing slash for
subdirectories. I need to check again if v5 sort order is compatible..
--
Duy
