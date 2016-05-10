From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v9 03/19] index-helper: new daemon for caching index and
 related stuff
Date: Tue, 10 May 2016 18:31:18 +0700
Message-ID: <CACsJy8BE5jjr=TQVyRNz0M2yxTsoXNQ=fU80rGDcm-SXy4ktcA@mail.gmail.com>
References: <1462826929-7567-4-git-send-email-dturner@twopensource.com>
 <20160510101315.32403-1-szeder@ira.uka.de> <CACsJy8DLmcxmw5aGT3FszccW3UNujBcr8uZzJuJoWxvASKnpPg@mail.gmail.com>
 <20160510131228.Horde.WHWUaWE4DeqFLnoMEbjxcxG@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue May 10 13:31:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b05tK-0002DE-CM
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 13:31:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbcEJLbu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2016 07:31:50 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:36382 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922AbcEJLbt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2016 07:31:49 -0400
Received: by mail-lf0-f50.google.com with SMTP id u64so11208166lff.3
        for <git@vger.kernel.org>; Tue, 10 May 2016 04:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0+CTqFcGrFQ412mh/CfWNWvcvpYCGllzoK7QTAgJQk4=;
        b=pHy7aRxTtRsWkJERezrk284R+c1qHDIaVM39xwwubkD9B57aR2yq0SWJU4zmCaK9RD
         2HQ4tJTm6XTPxHJm9uXtKjERdxhmi4k37/SNO9Upv/NJo/ueZ0vP7koBiK9HrwS7zPAw
         YSkoBViJxXEMALnOnDxIKvfZTXFgO3ijKsQyJW0RVWw6r4O6is9usWEUfjE94KPNl0rI
         6Zv1z4jMxCrdgVvCsyiKGbKRQ7I1pLY4meX1vOMdsvlUeLI6QMOaUvk4yIWZEJ+Brz/+
         fVWjLu+ZuAskBQBso/jLP0dM7EIaKBuCxEHjS3s4+121RA/5NZ60AP8+dHjGd5smPzPM
         z8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0+CTqFcGrFQ412mh/CfWNWvcvpYCGllzoK7QTAgJQk4=;
        b=eeNrnOi+oT3Vz/0Qv2WXeO8jIRe/Kpzjff9k1hnlVEXs7IYj9envWOb+eEF44PP+NB
         7BuYUagAVDdk7REu4upVQGGyeUTf1Mg+BcHcJ4PY1kp/GmxKjN1pvbKelCnyIKMzCsAu
         6qfHQEuF8o9YhR/y/2EdQjSI2tZl+ubLzcb6dwdii2McKbb9rgb41aGrJVM/SMoeqbtb
         Zn7G2p+Sfz12lE4lgWpnpCr16CEwxmwKxFhBxPXPB/0WoQUbQ1StlGX4czT+iKX8thfo
         70+ryGllPWgPXgOgZCk1Kvboaogdlv4PwCv7FlO4+dAVf1uHDqiofFgSdsIRwoG7Y5ei
         XCRg==
X-Gm-Message-State: AOPr4FU4/mMyAPDf662NgyZjaiqGwhdUija793Mo7mhc8nNTx/WbkVl5Q/23zlcsKRzsRUOtRt04uj/4lcAbrw==
X-Received: by 10.112.170.106 with SMTP id al10mr5999069lbc.12.1462879908193;
 Tue, 10 May 2016 04:31:48 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Tue, 10 May 2016 04:31:18 -0700 (PDT)
In-Reply-To: <20160510131228.Horde.WHWUaWE4DeqFLnoMEbjxcxG@webmail.informatik.kit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294119>

On Tue, May 10, 2016 at 6:12 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
wrote:
>
> Quoting Duy Nguyen <pclouds@gmail.com>:
>
>> This reminds me, we need to update command-list.txt as well. I guess
>> it belongs to purehelpers? Back to the patch..
>>
>> On Tue, May 10, 2016 at 5:13 PM, SZEDER G=C3=A1bor <szeder@ira.uka.d=
e> wrote:
>>>
>>> This patch adds a new plumbing command, which then will show up in
>>> completion after 'git <TAB>'.  Could you please squash in this
>>> oneliner to exclude index-helper from porcelain commands in the
>>> completion script?
>>
>>
>> I don't think the user should run this command explicitly a lot.
>> Usually it should be run automatically (with config key
>> indexhelper.autorun) and die when idle for some time. You just don't
>> care about it (until performance degrades and you have to
>> investigate). Occasionally you may have to "git index-helper --kill"=
=2E
>> Is there any other reason it should be run often enough to justify
>> this change?
>
>
> I think you misunderstood this change, it _excludes_
> 'index-helper' from the list of porcelain commands.

Oops, right it excludes it.
--=20
Duy
