From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH v2 03/10] t/t3511: add some tests of 'cherry-pick -s' functionality
Date: Sun, 27 Jan 2013 15:33:33 -0800
Message-ID: <CA+sFfMc0_QxwtJ6YS6H+GOW+Pzh3tSZs3rW-VSDf-GWeL=3tDA@mail.gmail.com>
References: <1358757627-16682-1-git-send-email-drafnel@gmail.com>
	<1358757627-16682-4-git-send-email-drafnel@gmail.com>
	<20130122081758.GD6085@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com, pclouds@gmail.com, git@vger.kernel.org,
	Brandon Casey <bcasey@nvidia.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 00:41:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzbr6-0006HN-Ke
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 00:41:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754647Ab3A0XlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 18:41:24 -0500
Received: from mail-wg0-f42.google.com ([74.125.82.42]:59438 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753840Ab3A0XlW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 18:41:22 -0500
Received: by mail-wg0-f42.google.com with SMTP id 12so883498wgh.1
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 15:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=dBfN1dWzXtiX/iEgL9KY8H8ocej0F5g3F/o8EeQ/H2E=;
        b=S5VmktEAGTeWf/LpoZ2RE5yyU4QDgN47Xa8cmDdQ2XikpF9USDNJEX7fNDWKhN2cln
         EC24EaWY3YaewKkmLwzwxDs+mhxvAg2mAM3L/Dmor+EUWOs5dkWZXiKIIOUpM8TYF3X5
         uTMC36YUPHDwgiBeGR+oT4WRLKYThtkLaBQgIAbfwBoQm1KHvsbgEfE+r2r8g5rM0QQi
         DkgI9ho9YS83lPG3Wl8SPLADFK1jFQ1dlj+pUdfO0OLXAtRYPg7LtIlSgUQ85KJGbFcJ
         psHO4b1Kj4S8KE+bChElAAmMb5+fpKO8SIe5NwgQDqo1MZPooUi3S8EMqFgA80cGq9v/
         EtjQ==
X-Received: by 10.180.88.40 with SMTP id bd8mr6576165wib.33.1359329613691;
 Sun, 27 Jan 2013 15:33:33 -0800 (PST)
Received: by 10.194.143.18 with HTTP; Sun, 27 Jan 2013 15:33:33 -0800 (PST)
In-Reply-To: <20130122081758.GD6085@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214754>

On Tue, Jan 22, 2013 at 12:17 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Brandon Casey wrote:
>
>> --- /dev/null
>> +++ b/t/t3511-cherry-pick-x.sh

> [...]
>> +test_expect_failure 'cherry-pick -s inserts blank line after non-conforming footer' '
>
> IIUC this is an illustration of false-positives from messages like
> this one:
>
>         base: do something great without a sign-off
>
>         If he does that, it will be the best thing in the
>         world: or so I think.
>
> A worthy cause.  Could the example broken message be tweaked to
> emphasize that use case?  With the current example, I'd consider
> either result (blank line or no blank line) to be ok behavior by git.

The primary motivation for this test was to exercise an existing
behavior which fails to append a newline and sob if the last line of
the last paragraph matches the sob of the committer regardless of
whether the entire paragraph would be interpreted as a conforming
footer.  Your example is tested as a side-effect of that.  I'll tweak
the string so it looks like this:

The signed-off-by string should begin with the words Signed-off-by followed
by a colon and space, and then the signers name and email address. e.g.
Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>

> [...]
>> +test_expect_success 'cherry-pick -s refrains from adding duplicate trailing sob' '
>
> And the other side of basic "-s" functionality.
>
> One more test would be interesting: what does "-s" do when asked to
> produce a duplicate signoff with an interspersed signoff by someone else?
>
>         test: a patch with a more complicated life
>
>         This patch bounced from $GIT_COMMITTER_NAME to Ms. Thor for
>         tweaking, then back to $GIT_COMMITTER_NAME who will be
>         recording it in permanent history.
>
>         Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
>         Signed-off-by: A U Thor <author@example.com>

This one exists as "adds sob when last sob doesn't match committer".
In this case an additional sob should be appended to the footer.

-Brandon
