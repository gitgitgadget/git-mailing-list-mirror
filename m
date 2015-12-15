From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 7/8] config: add core.untrackedCache
Date: Tue, 15 Dec 2015 17:02:20 +0700
Message-ID: <CACsJy8CG6LXpUaS09CqaoqLEqzexb14JA02o4HcoxdwM05QQ=g@mail.gmail.com>
References: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
 <1449594916-21167-8-git-send-email-chriscool@tuxfamily.org>
 <xmqqsi3ckadi.fsf@gitster.mtv.corp.google.com> <xmqqfuzck1dp.fsf@gitster.mtv.corp.google.com>
 <CAP8UFD3at0X9ThpXGTwyPnu_dXFj6x=YzfkCa82m+RsWwhFOOA@mail.gmail.com>
 <xmqq6100ke7v.fsf@gitster.mtv.corp.google.com> <xmqqa8pciuqq.fsf@gitster.mtv.corp.google.com>
 <CAP8UFD0ex4JuU=FMDwnSnf9io16=D2_m3x1ajXtCu25OU_DLAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 11:03:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8mRh-0006hf-Bn
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 11:03:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964908AbbLOKC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 05:02:56 -0500
Received: from mail-lf0-f44.google.com ([209.85.215.44]:34199 "EHLO
	mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964834AbbLOKCx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 05:02:53 -0500
Received: by mail-lf0-f44.google.com with SMTP id y184so2652260lfc.1
        for <git@vger.kernel.org>; Tue, 15 Dec 2015 02:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=09r8P2gwFptjjMtGIj7t6IT15xCTQMHYi+zEMHv7fHk=;
        b=goa/3yfplb28upxsJ6HbIng9+cr/8G2K5ScnBBScobdFty44Tf1mQZp9AQp38UtK0W
         x/3Guz+Sn8X+6wf5LQ+TB2JM+K3KKmuFwBnnhbsLpDAxRY8D+VkSuHLUP/zXQ/71dpgf
         xTgvrfiaA3YZMegwHcNzfxX1p+iM8YK06otqbzZHcl2hPRbp9JuGi1E1OY/TeKp0cflS
         1Kp9z/7IYLL2i2A1V2iSGVXZHMxMaEeAt30GlfiENVWWsnTOIn6TETw9oJAOEuxDSrg8
         wUOaVIhnMBxmd+irXClFyF+RK9sdr6trdt0x44k9cSBUuA1SyY4KNm2i4gyGJ9V+J/2O
         CoAQ==
X-Received: by 10.25.137.84 with SMTP id l81mr14880893lfd.45.1450173770350;
 Tue, 15 Dec 2015 02:02:50 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Tue, 15 Dec 2015 02:02:20 -0800 (PST)
In-Reply-To: <CAP8UFD0ex4JuU=FMDwnSnf9io16=D2_m3x1ajXtCu25OU_DLAw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282470>

On Tue, Dec 15, 2015 at 4:34 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Mon, Dec 14, 2015 at 10:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> The primary reason why I do not like your "configuration decides" is
>> it will be a huge source of confusions and bugs.  Imagine what
>> should happen in this sequence, and when should a stale cached
>> information be discarded?
>>
>>  - the configuration is set to 'yes'.
>>  - the index is updated and written by various commands.
>>  - more work is done in the working tree without updating the index.
>>  - the configuration is set to 'no'.
>>  - more work is done in the working tree without updating the index.
>>  - the configuration is set to 'yes'.
>>  - more work is done in the working tree without updating the index.
>>  - somebody asks "what untracked paths are there?"
>
> As far as I understand the UC just stores the mtime of the directories
> in the working tree to avoid the need of lstat'ing all the files in
> the directories.
>
> When somebody asks "what untracked paths are there", if the UC has not
> been discarded when the configuration was set to no, then git will
> just ask for the mtimes of the directories in the working tree and
> compare them with what is in the UC.
>
> I don't see how it can create confusion and bugs, as the work done in
> the working tree should anyway have changed the mtime of the
> directories where work has been done.

Any operation that can add or remove an entry from the index may lead
to UC update. For example, if file "foo" is tracked, then the user
does "git rm --cached foo", "foo" may become either untracked or
ignored. So if you disable UC while doing this removal, then re-enable
UC again, "git-status" may show incorrect output. So, as long as UC
extension exists in the index, it must be updated, or it may become
outdated and useless.
-- 
Duy
