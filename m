From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: RFC/Pull Request: Refs db backend
Date: Tue, 23 Jun 2015 17:23:09 +0700
Message-ID: <CACsJy8DA3oOt8QRsztdJXwmfUwDvY_nGALQrOpSA3M_eNSuT8g@mail.gmail.com>
References: <1435020656.28466.8.camel@twopensource.com> <xmqqvbefdm0d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 12:23:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7LMr-00027s-8d
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 12:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754435AbbFWKXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 06:23:40 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:35814 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754522AbbFWKXj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 06:23:39 -0400
Received: by iebrt9 with SMTP id rt9so8344819ieb.2
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 03:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jNthrur1tgkxA+ASKGnJU5SkuF3dckcyBirYgm7lgms=;
        b=DJvKJMjECCLG3nGuOy859rWF0furgZ7IAWlv9m4Xg0GG1PpVwolihh2I/xhNoeDZ8n
         Gk69XXuQctq5zEgyKZjXuVXjRTJF8XRNBli0KKFMTffe2XoGqo3NZzLSr2iwcXU21BXs
         HQTaLBzrDHWthRG1uoTpz8XC43UpmqgCKGi9/+W+G/m/5xtdS+bv6tYxcjhvcI5ii3pL
         8RdxzS9qqiaUvNTcgd4B6LqP7zR5kZv0Ky362gLHJcDwLt0/Twg9sLXS8qJVVZJdYkPu
         6bXsdQAnFIrgjRdTTkV01QSrrbfv58bWGYSOKf78vKzXYNPmdQF+QtEej1ff+k8/5FuK
         8pOg==
X-Received: by 10.43.172.68 with SMTP id nx4mr30386364icc.48.1435055018676;
 Tue, 23 Jun 2015 03:23:38 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Tue, 23 Jun 2015 03:23:09 -0700 (PDT)
In-Reply-To: <xmqqvbefdm0d.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272445>

On Tue, Jun 23, 2015 at 12:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "If there is interest"?  Shut up and take my money ;-)

Yeah. This may be the next big thing since pack bitmap. It's even
better if it enters 'master' hand in hand with pack protocol v2, but I
think v2 needs more time.

On Tue, Jun 23, 2015 at 7:50 AM, David Turner <dturner@twopensource.com> wrote:
> To test this backend's correctness, I hacked test-lib.sh and
> test-lib-functions.sh to run all tests under the refs backend.

Now we have two. split-index also benefits from running through full
test suite like this. I propose we make "make test" run the test suite
twice. The first run is with default configuration, no split index, no
fancy ref backend. The second run enables split-index and switches to
new backend, running through all test cases. In future we can also
enable packv4 in this second run. There won't be a third run.

When the second ref backend comes, we can switch between the two
backends using a random number generator where we control both
algorithm and seed, so that when a test fails, the user can give us
their seed and we can re-run with the same configuration.

> Dozens of tests use manual ref/reflog reading/writing, or create submodules
> without passing --refs-backend-type to git init.  If those tests are
> changed to use the update-ref machinery or test-refs-be-db (or, in the
> case of packed-refs, corrupt refs, and dumb fetch tests, are skipped),
> the only remaining failing tests are the git-new-workdir tests and the
> gitweb tests.

I haven't read the series, but I guess you should also add a few tests
to run on the first run, so new code is exercised a bit even if people
skip the second run.
-- 
Duy
