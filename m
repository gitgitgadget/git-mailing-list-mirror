From: Bryan Turner <bturner@atlassian.com>
Subject: Re: http-protocol question
Date: Tue, 2 Dec 2014 16:04:11 +1100
Message-ID: <CAGyf7-Gx1VU-1OicCHG0sStUnNXy_0Y8VYUP+PZjpN6nz7dTrw@mail.gmail.com>
References: <CAGyf7-HmvvHQZkyLgKAs2rrZTTLFkBa8s828hbS9LedLNb2fWA@mail.gmail.com>
	<20141202033416.GY6527@google.com>
	<CAGyf7-GZbRBN4O_yNgrmJCya=6f8XQ4O8m7WBa1k8Ve196ajYQ@mail.gmail.com>
	<20141202044522.GZ6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 06:04:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvfdW-0004SN-BG
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 06:04:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853AbaLBFEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 00:04:13 -0500
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:47780 "HELO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751619AbaLBFEM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Dec 2014 00:04:12 -0500
Received: from mail-ob0-f177.google.com ([209.85.214.177]) (using TLSv1) by na3sys009aob116.postini.com ([74.125.148.12]) with SMTP
	ID DSNKVH1ISzFUcV2teKaA3x7e2hW3XsFhJgRC@postini.com; Mon, 01 Dec 2014 21:04:12 PST
Received: by mail-ob0-f177.google.com with SMTP id va2so8837087obc.8
        for <git@vger.kernel.org>; Mon, 01 Dec 2014 21:04:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=6v1lZC9Rhw/8mqcVV6Ih3N0+x7fVVhZnhyq3rTx8phk=;
        b=R6QwWOlWGApCDZKWn2ZOOux7FKw519lT5qXCs4A1KSRw2b86wxUUrOTn6c8l4rQwU4
         J5MnqGfzw3NNj7tQMHXKowaoNMirtdPHkik8MBJjlFt7c3ouRMIynEl2bsN68419G8+p
         xcuuqBxemFYE+CXxMAp2/XNgKN9hPOpzxNKiVqkD7rOf1gdsXTgQ/x0Bd1t2FBBxJLD/
         PdHHFm/5y9VG3AwsMItESo9o5S8SGITJc6uSIUeztrntgKJ1b6i181hpRJOCQehZqRk9
         1o55GGe/sAFLuqAjXWTdNx0y0+wQJ3o1To+6TJSTntWJdywC7ZQFwCXvmxMJju/AHoTr
         KbBg==
X-Gm-Message-State: ALoCoQkp2CPFnfxwVi5j9nxsSwkSXVUckc8jvFwDhPZIYHgVxeXT2XGNgwjLL2FOdQx4/sEQvcd/ZxKP/oJ2DpNXPKNRMYHA/TQrq3RAlHmkls4GmU6yAKWFLS/mpKVfpC8m0uTuomOU7XAsb2/oUROqz87sdiDzpQ==
X-Received: by 10.202.2.79 with SMTP id 76mr35259392oic.106.1417496651620;
        Mon, 01 Dec 2014 21:04:11 -0800 (PST)
X-Received: by 10.202.2.79 with SMTP id 76mr35259385oic.106.1417496651512;
 Mon, 01 Dec 2014 21:04:11 -0800 (PST)
Received: by 10.182.245.170 with HTTP; Mon, 1 Dec 2014 21:04:11 -0800 (PST)
In-Reply-To: <20141202044522.GZ6527@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260532>

On Tue, Dec 2, 2014 at 3:45 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Bryan Turner wrote:
>
>> The reason I ask is that there is a race condition that exists where
>> the ref advertisement lists refs/heads/foo at abc1234, and then foo is
>> deleted before the actual upload-pack request comes in.
>
> Can you say more about the context?  For example, was this actually
> happening, or is this for the sake of understanding the protocol
> better?

I ask because it's actually happening. Heavy CI load sometimes has
builds fail because git clone dies with "not our ref". That's the
specific context I'm working to try and address right now. Some teams
use rebase-heavy workflows, which also evades the check_non_tip easing
and fails with "not our ref", so I can't be 100% certain it's ref
deletion in specific causing it (but I guess which of those it is is
probably largely academic; as long as hosting spans multiple requests
it seems like this type of race condition is unavoidable).

I'm trying to decide if there is something I can enable or tune to
prevent it, and the type of twilighting hinted at by the http-protocol
documentation seemed like it could be just the thing.

>
> I ask because knowing the context might help us give more specific
> advice.
>
> Sometimes when people delete a branch they really want those objects
> to be inaccessible *right away*.  So for such people, git's behavior
> of failing the request unless the objects are still accessible by
> some other path is helpful.
>
> A stateful server could theoretically cache the list of objects they
> have advertised for a short time, to avoid clients having to suffer
> when something becomes inaccessible during the window between the
> upload-pack advertisement and upload-pack request.  Or a permissive
> server can allow all wants except a specific blacklist (and some
> people do that).
>
> Jonathan
