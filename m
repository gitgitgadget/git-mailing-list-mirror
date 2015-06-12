From: Augie Fackler <augie@google.com>
Subject: Re: [PATCH v2] fetch-pack: optionally save packs to disk
Date: Fri, 12 Jun 2015 13:02:43 -0400
Message-ID: <CAHcr6HYv+3z+QLFqwKxVFNOu0Nk4pfWeVhGe_bxu6Fn=wruD8Q@mail.gmail.com>
References: <CAGZ79kaS4utvDbXOo7emmSUH6M-8LY-oA65Ss3PLDkFModkbSg@mail.gmail.com>
	<1434049168-10613-1-git-send-email-augie@google.com>
	<557A7ABA.2000404@kdbg.org>
	<xmqqmw05dkxz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 19:02:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3SLy-0000lR-3v
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 19:02:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755812AbbFLRCq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 13:02:46 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:35909 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222AbbFLRCp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 13:02:45 -0400
Received: by wigg3 with SMTP id g3so22478787wig.1
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 10:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=KNCUGLNqERS5hNBB3enQruRAO137FNaAv9mD4wtMnc4=;
        b=WTTaWlGqNPKruEVdtT1Ll+Bgez8thiyLpgZCRjA8bEFSODtYq/nUuNJ5Z63Jz60Bxj
         IY6pDps7lNsscrk7bRTkQ3BJdWR8ouV2CVGI3B36lx1eXzFxn6yIA8jvfE70fochUCTb
         z2FjxGYF8fpHIrt/UvwXJTRyCI8+RlD5YEypDEs9vKHQ/gBoGIesDBhHxGSMwbWDTi9I
         ECpragiVVhc2BD/Az1/3FCbvfIqU5pa7r5990VjoZreECFOhLXI1iMAk9MD7cDLDLVFj
         LWX/DgUmtKVhDk4v5w1BhCczuFWCgyo2PlNd61me5cyrD8xSSNBhL3JtjFRs7Eg1aD7v
         ElcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=KNCUGLNqERS5hNBB3enQruRAO137FNaAv9mD4wtMnc4=;
        b=QUlrR15zgdXa2fUvmRKK0YFqeK4p4x9++W1ot32E/fVmMRqk6R6YOqbxmf5v1ZGzvt
         hzptF0FCmBf7cZLU5dLwlPqb+2YRhH5NXHF6SI/hXX/3kE+yON3Y0Gk3Qky5/n2QZUjK
         11SMB5i7JqguhyizHDryPGqK/evGcUBm8XP+6i2y7vWzfhn4d5Wssur44APrWC2s66Sr
         NhI4UolCWOkOPyRlxeedo6WSdBcHQ+hygxfCUG5Hv+mke/TfD6FeLytHG+XBAr0GeHds
         FgjbzjkdbLG9i9o2SmlNNiWlb016PXZdnNMScJhrfusPzVke2tkF//wB+puFmplsyhpw
         c6oQ==
X-Gm-Message-State: ALoCoQm14cK/F6YqmC/jwfpiYP47SD8lDGojf73IAY30/Hu4t/TVV6rjHKaTlvCWcFRSi/WaGdEq
X-Received: by 10.194.185.236 with SMTP id ff12mr28513733wjc.134.1434128563886;
 Fri, 12 Jun 2015 10:02:43 -0700 (PDT)
Received: by 10.28.146.143 with HTTP; Fri, 12 Jun 2015 10:02:43 -0700 (PDT)
In-Reply-To: <xmqqmw05dkxz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271499>

On Fri, Jun 12, 2015 at 11:07 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> What is the problem with the current fetch-pack implementation? Does
>> it remove a bogus packfile after download? Does it abort during
>> download when it detects a broken packfile? Does --keep not do what
>> you need?
>
> Doesn't the incoming data still go through the fattening process,
> though?  You will not be able to inspect the byte-for-byte identical
> stream that came out of the server end whose packfile generation
> logic is suspect.
>
> For the purpose of debugging your own new server implementation, it
> might be a better approach to capture the pack as it comes out at
> the server end, instead of doing it at the fetch-pack end as it
> comes in. But the approach to add this "dump" at the fetch-pack side
> is that it gives us a tool to diagnose problems that come from
> broken server (re)implementations by other people we cannot debug,
> i.e. "you are spewing this corrupt pack against this request; here
> is a dump we took to help you go fix your server".

*nod* that's an important part of it. Also, in the small-pull case,
the pack data gets sent to unpack-objects anyway, so git is never
saving the packfile anywhere in that case (I think it's for a pull of
less than 100 objects, which characterizes most of my reduced test
cases for weirdness.)

>
>> Instead of your approach (which forks off tee to dump a copy of the
>> packfile), would it not be simpler to add an option --debug-pack
>> (probably not the best name) that skips the cleanup step when a broken
>> packfile is detected and prints the name of the downloaded packfile?
>
> As long as we need to debug a thin pack that comes from the other
> end, that approach is not sufficient, I am afraid.
>
> I anticipated that you'd have problem with its use of "tee".  It
> probably can do this internally with async interface, perhaps,
> instead?

I'd be happy to make such changes if that's the consensus and someone
can give me pointers. My C is admittedly pretty rusty from non-use,
and I'm not at all familiar with git's codebase, but I'll at least
try.

Thanks!
