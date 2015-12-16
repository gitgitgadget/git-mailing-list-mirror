From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC] Malicously tampering git metadata?
Date: Tue, 15 Dec 2015 23:20:04 -0800
Message-ID: <CAGZ79kZNim0wp2fYKv2+6t+CaqqzjTThsm_KoAv1D_8OsD0qTQ@mail.gmail.com>
References: <20151216032639.GA1901@LykOS>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Wed Dec 16 08:20:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a96Ni-0005Nq-Db
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 08:20:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932639AbbLPHUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 02:20:08 -0500
Received: from mail-ig0-f169.google.com ([209.85.213.169]:38038 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932197AbbLPHUG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 02:20:06 -0500
Received: by mail-ig0-f169.google.com with SMTP id xm8so36764378igb.1
        for <git@vger.kernel.org>; Tue, 15 Dec 2015 23:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HFJ7YcbAwmm96IGtU3Yf189qn0mqc6QikVjlLQXVVXY=;
        b=E3Mg90FMqfJkprECXAaZvQKz6DFTsS+pKWy3bGc/wRN8ycFfAFgpC12cjMmvXxu0+S
         NxMeTy8kT5aJ7SFIxaW4/ETDsfgzVzkDj1NgI5UlqslYua3avPeX/QAEDm+PjSvcn6kh
         7ccFbiTbo7eAdpNw9cJE1HGTfVeDVIZr8/2qHy96aBO2fEQKHEvKfNjykSTPFmQcJwzm
         CoD/eD0bUNMbm4Yw2z/0s0h2w+JvWJOsrjIt+4Tqdumgf8w6piGOGxMdzVDdY22+oze4
         AU+8Vh8ncPwSMZmIqA2WxdQSh0qcBTslZD///DCaD7ZPfrKeqeFEcivB5edtUh8gCwjq
         pmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=HFJ7YcbAwmm96IGtU3Yf189qn0mqc6QikVjlLQXVVXY=;
        b=JU8mjE6bZuwbzfzPw2WTg1HPyaONUG4qqI3Fe1nJYZ4Im+Z3TYDF1hMM9X6MXLgmll
         SDJTqEVNZNaD7f/1XIZXbcuKCKqxY5hWAMfyinf220QJYclL/4LIsbOanK8KejqwcrFp
         Qr5OPt9gyMzhhSZqDHRRB3WJOMZb8ZOmFY6b4E4EBSgr5maA2RG9DgHIBJ+8JtNHgN3m
         oB+K02gI5FqQh8R8Sc3MnpeqU1GGOQKMtDWtn0sEVlnjcgtyWASPrJhzoFP3UsXY+/hy
         PmckEyL1O5NZDosjtGIAdTlm8J0zRZoCpYxdr8gdqXcGiAUBq39FAwilJKeYY1tH0Yti
         IeAw==
X-Gm-Message-State: ALoCoQn2CpWXTsID8H5J88Hv2gkwvb4Ljkb1QM8ztJDBnkxOGenhuy6vCxIJmWvYv4SbGPuXMek4vManaF8yDKc+yEE52MdzpdGjYaGbQveExYPilJZIJLo=
X-Received: by 10.107.152.142 with SMTP id a136mr46461100ioe.110.1450250405080;
 Tue, 15 Dec 2015 23:20:05 -0800 (PST)
Received: by 10.107.8.84 with HTTP; Tue, 15 Dec 2015 23:20:04 -0800 (PST)
In-Reply-To: <20151216032639.GA1901@LykOS>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282538>

On Tue, Dec 15, 2015 at 7:26 PM, Santiago Torres <santiago@nyu.edu> wrote:
> Hello everyone,
>
> I'm Santiago, a PhD student at NYU doing research about secure software
> development pipelines. We've been studying different aspects of Git
> lately, (as it is an integral part of many projects) and we believe
> we've found a vulnerabilty in the way Git structures/signs metadata.
>
> An attacker capable of performing as a Man in the Middle between a
> GitHub server and a developer is able to trick such developer into
> merging vulnerable commit objects, or omit security patches --- even if
> all users sign all commit objects. Given that Git metadata is unsigned,
> it can be modified to provide incorrect views of a repository to
> downstream developers.
>
> An example of a malicious commit merge follows:
>
> 1) The attacker controlling or acting as the upstream server identifies
> two branches: one in which the unsuspecting developer is working on, and
> another in which a vulnerable piece of code is located.
>
> 2) Branch pointers are modified: the packed-refs file (or ref/heads/*)
> is edited so that the master branch points to the vulnerable commit
> object. Having performed the change, no additional configuration must be
> made by the attacker, who now waits for an unsuspecting developer to
> pull.
>
> 3) Once a developer pulls, he or she will be prompted to merge his code
> with the new change-set (the vulnerable commit). This operation will
> only resemble developer negligence. If no conflicts arise, the attack
> will pass unsuspected.
>
> 4) The developer pushes to upstream. All the traffic can be re-routed
> back to the original repository. The target branch now contains a
> vulnerable piece of code.
>
> We have identified additional attack scenarios for modifying the
> metadata that result in a incorrect state of the target repository, and
> we are ready to disclose information about other variants of this attack
> as well.
>
> We also designed a backwards-compatible defense mechanism to prevent
> attacks based on Git metadata tampering. Also we implemented a proof of
> concept of the scheme, and performed timing, stress and concurrency
> tests; our results show that the overhead should be minimal, even in
> large software repositories such as the Linux Kernel.
>
> We already approached people from CERT and GitHub regarding this attack
> scenario, and we'd also like to hear your comments regarding this.

This is what push certificates ought to solve.
The server records all pushes and its signed certificates of pushes
and by the difference of the
refs (either in packed refs or as a loose ref) to the push certificate
this tampering of
the server can be detected.

The push certs can however not be obtained via Git itself (they are
just stored on the
server for now for later inspection or similar), because to be really
sure the client would
need to learn about these push certificates out of band.

The model there would be:
* A vulnerable piece of software exists.
* It get's fixed (and the fix is pushed with a signed push)
* the MITM server doesn't show the fix (show the code from before fix) nor
  the push certificate thereof
* client still pulls vulnerable code

This model shows the distribution of push certs via the server itself may not be
optimal.

Thanks for researching on Git,
Stefan

>
> Thanks!
> -Santiago.
>
> P.S. We also elaborate more about this attack vector in this document:
> https://drive.google.com/a/nyu.edu/file/d/0B2KBm0fULlS1RDR5UHVESjVua3M/view?usp=sharing
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
