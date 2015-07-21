From: Doug Kelly <dougk.ff7@gmail.com>
Subject: Re: Question: .idx without .pack causes performance issues?
Date: Tue, 21 Jul 2015 16:37:12 -0500
Message-ID: <CAEtYS8QEuEA6d13FH_0_ZbT9YbJ_UdvhkSBYq1xyGCAuznh-GQ@mail.gmail.com>
References: <CAEtYS8QWCg5_DtrJw-e+c50vcG0OpciR6LWon-3GgyngGn+0pQ@mail.gmail.com>
	<xmqq4mkxwd77.fsf@gitster.dls.corp.google.com>
	<xmqqzj2puxu2.fsf@gitster.dls.corp.google.com>
	<xmqqtwsxtey8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 23:37:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHfE5-0003nW-Qc
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 23:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756062AbbGUVhP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 17:37:15 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:36934 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756007AbbGUVhM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2015 17:37:12 -0400
Received: by igbpg9 with SMTP id pg9so118223401igb.0
        for <git@vger.kernel.org>; Tue, 21 Jul 2015 14:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2xVJZ7NSAZZdHtC5k/XimVjp3UXXzjROI3XI0C8U9es=;
        b=MZaeNEpiDOb0/jwZXaQL3aJVaFkxA0igaDoEaJsb1dwnUnoC2IaYCoilzmFyyQ783m
         plzB95EaURTBVshpGNWvJVgPVpZI0bYJnWdgdSNHjFTTvqaKQbCckXSA2fzXutwVWXpn
         xXHcDyG2dO4yPEx7DlkUIrt7qHaGqHNottagwBtt8GUAB3yqDVYrZUwAuV1uHeyd81mv
         UvJnIjATp/hcJvY9dDiitcjBbdHdHimy6LiGzS3eO5Vctz4GPpH43QaTqHiY6dfDzmUH
         PMzTUM9Z0NXQq/BjFbKXDIr19RBqfa9BKzFA5N78OLNlvCAmDDW/HK2w7mHAsnBe50VT
         AkYQ==
X-Received: by 10.50.72.69 with SMTP id b5mr28821658igv.65.1437514632284; Tue,
 21 Jul 2015 14:37:12 -0700 (PDT)
Received: by 10.50.12.166 with HTTP; Tue, 21 Jul 2015 14:37:12 -0700 (PDT)
In-Reply-To: <xmqqtwsxtey8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274428>

On Tue, Jul 21, 2015 at 3:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> While I still think that it is more important to prevent such a
>> situation from occurring in the first place, ignoring .idx that lack
>> corresponding .pack should be fairly simple, perhaps like this.
>> ...
>
> Sorry for the noise, but this patch is worthless.  We already have
> an equivalent test in add_packed_git() that is called from this same
> place.

And a few extra updates from me: we found that this appears to occur
even after update to 1.9.5, and setting core.fscache on 2.4.6 has no
appreciable impact on the time it takes to run "git fetch", either.
Our thought was antivirus (or something else?) might have the file
open when git attempts to unlink the .idx, but perhaps it's something
else, too?  In one case, we had ~560 orphaned .idx files, but 150
seems sufficient to slow a fetch operation for a few minutes until it
actually begins transferring objects.

The "git gc" approach to cleaning up the mess is certainly looking
more and more attractive... :)
