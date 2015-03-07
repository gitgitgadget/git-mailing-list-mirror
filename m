From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] protocol upload-pack-v2
Date: Sat, 7 Mar 2015 12:21:00 +0700
Message-ID: <CACsJy8DX6pg7XthfsdtKXstPAiT67C2Hf=vqJZz-199+fZko1w@mail.gmail.com>
References: <20150302092136.GA30278@lanh> <1425685087-21633-1-git-send-email-sbeller@google.com>
 <xmqqr3t1vefz.fsf@gitster.dls.corp.google.com> <CAGZ79kZBYFSwR6E86BF6Dt7xdh0zs07tkGnQAKfEJpSduTK-aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 06:21:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YU7BA-0005K8-2i
	for gcvg-git-2@plane.gmane.org; Sat, 07 Mar 2015 06:21:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbbCGFVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2015 00:21:33 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:37991 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356AbbCGFVb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2015 00:21:31 -0500
Received: by iecrl12 with SMTP id rl12so8150037iec.5
        for <git@vger.kernel.org>; Fri, 06 Mar 2015 21:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=abt5K3ja/ZCgGoI4bAsv7z9VAjkEHF8o95PgFLzXmII=;
        b=TsEW8odZye3KIXTaf/0gs4/ElzA88EfJL/oIePofnQuFPkt+OYLRSEj6eZ2lp4DAAO
         9YrE1j2d0hMWgI3FHGiDnIFCxhTqGQ9D3IB/OZXnHBKU/5xD2Vyd6QkgT+RaBGDWA2S0
         SO5fnC6zNdboaPvmUSQFrqh+jY+20N5+LHq8LH42j3cyuDPthPWNbTsOsRgjHD9hX75s
         RxSfwr9LAdWiIhziM/APo3sgQnZsDdrJVbW+qCMCjEjRmTRXaP3wXQq9cXJhDmtF9td4
         hjcvby4TjTYSvqkdlVWnZavkp1Re//0tpW9eIzgQ5mUh5DCWpOI392eK3gsjWvU9jM/D
         2u4g==
X-Received: by 10.50.107.7 with SMTP id gy7mr32668006igb.49.1425705691024;
 Fri, 06 Mar 2015 21:21:31 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Fri, 6 Mar 2015 21:21:00 -0800 (PST)
In-Reply-To: <CAGZ79kZBYFSwR6E86BF6Dt7xdh0zs07tkGnQAKfEJpSduTK-aw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264990>

On Sat, Mar 7, 2015 at 11:28 AM, Stefan Beller <sbeller@google.com> wrote:
>>> +----
>>> +  advertised-refs  =  (no-refs / list-of-refs)
>>> +                   *shallow
>>> +                   flush-pkt
>>
>> I am not sure if defining "shallow" as part of "refs advertisement"
>> is a good idea.  The latter lives in the same place in the v1
>> protocol merely because that was how it was later bolted onto the
>> protocol.  But this concern can easily be allayed by retitling
>> "advertised-refs" to something else.
>
> I don't quite understand this. What are your concerns about shallow here?

This made me look for explanation about these shallow lines (commit
ad49136).They are sent when source repo is a shallow one. They tell
the receiver about the bottom the source repo. My experiment with "git
clone --since" shows that such a shallow clone could end up with a few
thousand shallow lines. Not as many as refs, but sending shallow lines
this way still cost more than necessary. If we want to do that, we
need more flexibility that just sending all shallow lines this way.

One of the approach is, because these shallow lines (on source repo)
rarely change. We could simply exchange SHA-1 of the source repo's
"shallow" file first. The client only requests shallow info when SHA-1
does not match.
-- 
Duy
