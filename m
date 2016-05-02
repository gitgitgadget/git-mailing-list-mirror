From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 04/14] connect: rewrite feature parsing to work on string_list
Date: Mon, 2 May 2016 11:46:41 -0700
Message-ID: <CAGZ79kbUekUtfzmW00UbCy-Qpu5jVM0gE-6n=4N5++-T+Ed8+g@mail.gmail.com>
References: <1461972887-22100-1-git-send-email-sbeller@google.com>
	<1461972887-22100-5-git-send-email-sbeller@google.com>
	<1462213121.4123.58.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon May 02 20:46:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axIrs-0005Ja-H6
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 20:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754985AbcEBSqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 14:46:44 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:38761 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754839AbcEBSqm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 14:46:42 -0400
Received: by mail-ig0-f179.google.com with SMTP id m9so351404ige.1
        for <git@vger.kernel.org>; Mon, 02 May 2016 11:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=mSoKHmF2jWZh65LzNaq9JuqN1n6B6JnOSTxvtTV1JUo=;
        b=kYVbyDkph/GiQ6bSt5CkbuFTgRyvFBEqv2dBGic7tOAnEbzOZMMpYMx8aSQHhsK8nl
         UFMOhBlULueRN9Eb/AcDQvAbZdQR9Cz1QauZb9e1R7q8t1NpkbBko/lP5pUOWjah6jEO
         oZss/dFVKKNtkcR/NvWdT8YObAbxAqGckVq9dMAcLdTPejiir+GuqiD8D/L9grdqRNPi
         FJmTyHRYaTqDMcbRFSUyQ85GtccR+SyrvzfpDwLg2iinj+eweLYUWbTbwxV1+rGJxoQ9
         8eI58sOfJv94xtyp9DWFy6C7jLKpn98IP6zLeYJqZUDpVLc2jGyuofaypL5dGDIOtGkR
         Zwpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=mSoKHmF2jWZh65LzNaq9JuqN1n6B6JnOSTxvtTV1JUo=;
        b=P58DVQNTeGaEe9H/F3w0diYDPUkHWDaRgUsR4rMWRAdAjDL2bTYfR6ENQXLts/Jy8x
         aNO+rXEUODAHyR6ZcY1Lvd0gSyMFQw6FoahBaAc6HJ11R2zId0z8csHGUzzX3CLVzaPA
         o7U9vYGJdv62mXBXBc8v53cdVDQRKQzl0IwaxBiZ77qgbMBTk13lnuM7B0IdXSHdTvB8
         koGXaRjYDVkVxfNNcvZD/rhaeylUC0LOGC6CgIekI3/d5X19gGTr95K4c0hd8t/c5Jft
         45Z/5zFTXi/1kglTGEvk0699q/K6pya5c39/mkDyW317bAsXzuRrdH1cDYZUlH51jYFm
         wJiA==
X-Gm-Message-State: AOPr4FVJfZbDuvS4SCrpH7bGACRaVsnQgySziQ7YBi1bjkEQMVVZmC+QMSnpPi+S4VlkW+u0sa4DuevQq+vbig0g
X-Received: by 10.50.102.207 with SMTP id fq15mr22929309igb.94.1462214801703;
 Mon, 02 May 2016 11:46:41 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 2 May 2016 11:46:41 -0700 (PDT)
In-Reply-To: <1462213121.4123.58.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293265>

On Mon, May 2, 2016 at 11:18 AM, David Turner <dturner@twopensource.com> wrote:
> On Fri, 2016-04-29 at 16:34 -0700, Stefan Beller wrote:
>> +             if (skip_prefix(item->string, "symref", &val)) {
>> +                     if (!val)
>> +                             continue;
>
> This if should never happen (skip_prefix returns 0 in that case).  You
> probably meant !*val -- but:
>
>> +                     val++; /* skip the = */
>
> I think you should instead skip_prefix "symref=" because:
> (a) it saves some code.
> (b) it allows for capabilities like symref_foo to later be added.
>
>> +     struct string_list list = STRING_LIST_INIT_NODUP;
>
> Maybe move the scope of list into the while loop below?
>
>>       char *line = packet_read_line(0, NULL);
>>       while (line) {
>> -             parse_features(line);
>> +             string_list_append(&list, line);
>> +             parse_features(&list);
>> +             string_list_clear(&list, 1);
>>               line = packet_read_line(0, NULL);
>
> This is a bit convoluted in the one-feature-per-line case, but I guess
> I understand that for the sake of generality it's useful.

Thanks for the review,
Stefan
