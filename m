From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] git clone depth of 0 not possible.
Date: Tue, 8 Jan 2013 21:45:27 +0700
Message-ID: <CACsJy8AEb9JsDOZfrXEj3VdMJU4hozjuZHaundQQyDNtaDQeHw@mail.gmail.com>
References: <1357581996-17505-1-git-send-email-stefanbeller@googlemail.com>
 <20130108062811.GA3131@elie.Belkin> <7vip78go6b.fsf@alter.siamese.dyndns.org>
 <7vd2xggm8a.fsf@alter.siamese.dyndns.org> <CACsJy8BJ3eBv-wjq=eTzR4SeEXW2MF5k1w5SFRt7fWRU4vKb_Q@mail.gmail.com>
 <50EC2DE5.2050704@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de,
	git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 15:46:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsaRV-0004Yt-Ol
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 15:46:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756506Ab3AHOp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 09:45:58 -0500
Received: from mail-ob0-f172.google.com ([209.85.214.172]:46322 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756442Ab3AHOp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 09:45:57 -0500
Received: by mail-ob0-f172.google.com with SMTP id za17so430583obc.3
        for <git@vger.kernel.org>; Tue, 08 Jan 2013 06:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+x+3rjthyrFyfQlK4frpSHLXl3BM42f4sEapb5Y4MFk=;
        b=s15LA2yeKo2dsixh7w2C9CJjiWXj2zKs4IxqKf9Fc3F6UsSVJGMOz+ePmZzEA9r/kr
         lwwMkFyxbYLblEMOwPrT0laeplrP5rZ9hP7mzEDMKWogS9hHzw/Ha3Vl0IeBsENbP4yH
         zyb3M0MYXEfvRiNdW/rmmggL24Sk9YZuYlUJqQ9Ka+Rn/yWX4+KqKXCwNv13WzpT6MCP
         NaouPT7vQmbQZsvKmF4AZs+4jmwYSTxakaOXoPYU6Tkke/+irEudqvOpR8DnM6n37fPh
         tAdGZiCHhU8XCNQWgsgm8wqzbylogz8qV6OAw51+tFsVRlGvVe+09Pq2JGIvRNk7cF4R
         6s8g==
Received: by 10.182.159.33 with SMTP id wz1mr38877569obb.57.1357656357329;
 Tue, 08 Jan 2013 06:45:57 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Tue, 8 Jan 2013 06:45:27 -0800 (PST)
In-Reply-To: <50EC2DE5.2050704@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212968>

On Tue, Jan 8, 2013 at 9:32 PM, Stefan Beller
<stefanbeller@googlemail.com> wrote:
> On 01/08/2013 03:28 PM, Duy Nguyen wrote:
>> On Tue, Jan 8, 2013 at 2:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Speaking of --depth, I think in Git 2.0 we should fix the semantics
>>> of "deepening" done with "git fetch".
>>
>> Speaking of 2.0, we should support depth per ref. Well we don't have
>> to wait until 2.0 because we could just add shallow2 extension to the
>> pack protocol. We should also apply depth to new refs when fetching
>> them the first time.
>>
>
> Would this mean I could do something along?
> $ git clone --since v1.8.0 git://github.com/gitster/git.git
>
> So tags would be allowed as anchors?

No. This is what I had in mind:

git clone --branch=master --depth=2 git.git # get branch master with depth 2
git fetch --depth=10 origin next            # get branch next with depth 10
                                            # master's depth remains 2
git fetch origin                # get (new) branch 'pu' with default depth 2

But your case is interesting. We could specify --depth=v1.8.0.. or
even --depth=v1.8.0~200.. (200 commits before v1.8.0). Somebody may
even go crazy and make --depth=v1.6.0..v1.8.0 work. --depth is
probably not the right name anymore. Any SHA-1 would be allowed as
anchor. But I think we need to wait for reachability bitmap feature to
come first so that we can quickly verify the anchor is reachable from
the public refs.
-- 
Duy
