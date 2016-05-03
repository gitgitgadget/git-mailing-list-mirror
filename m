From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 03/14] upload-pack-2: Implement the version 2 of upload-pack
Date: Tue, 3 May 2016 07:31:02 +0700
Message-ID: <CACsJy8DxwQKcno0ikZCDZUQ3xAd-iWw9mqSGnzgb5GqdRwHsYA@mail.gmail.com>
References: <1461972887-22100-1-git-send-email-sbeller@google.com>
 <1461972887-22100-4-git-send-email-sbeller@google.com> <1462210997.4123.49.camel@twopensource.com>
 <CAGZ79kavBUohoMcC3iEws5mVBQ6HZsR=HyBoxM1jxUVJ6Z1jkA@mail.gmail.com> <1462215375.4123.69.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue May 03 02:31:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axOFg-000539-3o
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 02:31:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbcECAbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 20:31:37 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36381 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932353AbcECAbe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 20:31:34 -0400
Received: by mail-lf0-f68.google.com with SMTP id y84so386202lfc.3
        for <git@vger.kernel.org>; Mon, 02 May 2016 17:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8f3HWPAChuC9wsru4rf4YWvrKABNfvFJ1ptvAHO3N8w=;
        b=PDME+RMgDehYAyPJSE75pveLfzt4o1lVCFfpHLtfy26umfiY6CMVPfTpX3W89QtY1T
         sbfOnZNDmVp0m0IjhoBSdNnmjFYNC75/9XMIquTMESya1bS2///8m4t3jehbtbRvwy/A
         +HuYasiERQwoBWV/3wPYTJzFFEkLj9lv3MtznL6ZUzmWoBUIeIXEDmNENj+3NieHWW4Z
         o/vrf05Afx5I4FaspKwek2ANTon984a81FQrOg2cxYtjzqv2QHliP/y3BEw0JAdhryAd
         FHBC2bPdi3gDk30aONTEs8ynQUNIG9Q9FHfiMUQAMkST34hzanQ7cb+a/jr0cLTLLHKm
         mIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8f3HWPAChuC9wsru4rf4YWvrKABNfvFJ1ptvAHO3N8w=;
        b=NYWfoKTSgkPIgtiZMfzQThIT4ePO4iZoUTV0bnf+1Z21vc38eTd/sxv3o70Nw4UCWu
         zxEU6KepofHBGPqODp9mKYp8ny27YjLoO22kjIi90UraKrlEUX9HyCkiwHjEywMES9iz
         zB74Dx5TnhZeE2RXiJPC7SbYbDhVlYMu9sTUcEu+8so/DeBOTpshei8YGjNTX9Y7V4Rj
         S4slK6FeuKFSzI7DrgH1X60YNyWjErNAO6gaU3deqoOE0t5+PSStStxLuDTwsVE+d5s0
         I/fjdUF9nISAzFEuERTJM7JGcR9ZoWTZn1mC3jcZeGjcleCpInl3Cu2o6dFQcdcy/O0a
         OW2w==
X-Gm-Message-State: AOPr4FXDegUJfhv5+ETIShR5wsHs04Jg6C4OnnYtt9V3C2k9KdDJVxUg6uhFm/akIriijZzZfq91BPHMHtlT2Q==
X-Received: by 10.25.22.19 with SMTP id m19mr16114606lfi.118.1462235492291;
 Mon, 02 May 2016 17:31:32 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Mon, 2 May 2016 17:31:02 -0700 (PDT)
In-Reply-To: <1462215375.4123.69.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293313>

On Tue, May 3, 2016 at 1:56 AM, David Turner <dturner@twopensource.com> wrote:
> On Mon, 2016-05-02 at 10:51 -0700, Stefan Beller wrote:
>> On Mon, May 2, 2016 at 10:43 AM, David Turner <
>> dturner@twopensource.com> wrote:
>> > On Fri, 2016-04-29 at 16:34 -0700, Stefan Beller wrote:
>> > > In upload-pack-2 we send each capability in its own packet
>> > > buffer.
>> > > The construction of upload-pack-2 is a bit unfortunate as I would
>> > > like
>> > > it to not be depending on a symlink linking to upload-pack.c, but
>> > > I
>> > > did
>> > > not find another easy way to do it. I would like it to generate
>> > > upload-pack-2.o from upload-pack.c but with '
>> > > -DTRANSPORT_VERSION=2'
>> > > set.
>> >
>> > Couldn't we check argv[0] and use that to determine protocol?  Then
>> > we
>> > could symlink executables rather than source code.
>>
>> IIRC I proposed a similar thing earlier, i.e.
>>
>>     if (argv[0] ends with 2)
>>         do_protocol_v_2(...)
>>
>> but that may break (and confuse a lot!) some use cases.
>> `git fetch` has the documented --upload-pack switch, so as a server
>> -admin
>> you are free to have git-upload-pack linking to
>> "git-upload-pack-2.8" but additionally you still have
>> "git-upload-pack-1.7" or "git-upload-pack-custom-2".
>>
>> so I think we should not do that :(
>> I do like to symlink the executables though.
>
> I think it would probably not break anyone if the new executable name
> were sufficiently distinctive -- e.g. starts_with (strrchr(argv[0],
> '/'), "git-upload-pack-protocol-v2"). But it would make custom
> executables a bit more complicated for the future.
>
> I guess it is better to have silly source code but clean binaries than
> clean source code but silly user-visible rules.

Maybe add --version to upload-pack? Then we can have a script
git-upload-pack-v2 that does "exec git upload-pack --version=2"
-- 
Duy
