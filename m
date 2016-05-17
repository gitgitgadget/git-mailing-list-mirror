From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC-PATCHv6 4/4] pathspec: allow querying for attributes
Date: Tue, 17 May 2016 10:03:38 -0700
Message-ID: <CAGZ79kbYB_4KO+XpYa0OhAcU63Q2M2kLWa03HcxeYS1HJOgfZw@mail.gmail.com>
References: <20160517031353.23707-1-sbeller@google.com> <20160517031353.23707-5-sbeller@google.com>
 <xmqqvb2dxomo.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 17 19:03:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2iPJ-0000gM-BL
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 19:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbcEQRDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 13:03:41 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:32993 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbcEQRDk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 13:03:40 -0400
Received: by mail-io0-f181.google.com with SMTP id f89so31725361ioi.0
        for <git@vger.kernel.org>; Tue, 17 May 2016 10:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SNJfjzLY9qflZvgaLoxcLaxSBnA8U6FYWlupTU8XTfQ=;
        b=VvNYqtF4fnJ10kMlKWuC/EH+h6YWhSGUKPX/gP7yLD717WU5CTIanfWrFjTllEIiOY
         +3F/UzepvErqpHXekFfVnNyHPWagwx7qi6Hjq/oDbYyTJYR8IKarR3gDeG4/wYoT5XGc
         M/FdoEHfwg9kNg+U8eEsnCXzyKmZN3GZcMp1gLXjeIIMnJ6HOCjhHD1M/VMvdrmPIDkC
         P1wAp6H7qPcTFyJsvMHWUKy+fiABZLZD+c1lbq1yr5epWRuDJuAB0NbJyATqF89ghhsg
         m004AX+xgChOVvg1uhZ9l+mBILlOCWI3shRDOumCWaCXgK1nbiiP3gbBJjJLVlon8Y+G
         /RAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SNJfjzLY9qflZvgaLoxcLaxSBnA8U6FYWlupTU8XTfQ=;
        b=g5bqHHLLV7YA07hyV18WrMn3gBOQjeCRfk3uCXuQBOPeXS5r4F/gZNdP5d6rE2tG/v
         3qLUj11iZPvjlw+n4UnS+8qaa8u04wLxIqyHjb+aDewl/aQDYB5vMGfrpc/PtD1Vugot
         ZBPjGH2/taiV/AIwCRCJ/qAn9x8HDirmfsO6FeOY1idGQzebpv99A2F79XWbxXaBxsA1
         EtlIojWmOvemj2RAsZN8xmogpygsK2WLIWstfmEcHW2czZ5u6d3FlmvHkny0RjA9nWPV
         Q/HWM4R2/EWeFafOIja3bwRCfVS4mj7ghSAXiJ6ZPkJt46CdqzdxPWNxSdhEL6u6a6dK
         TAiw==
X-Gm-Message-State: AOPr4FUEFKdBIMFXD20PtMDcd4D5BH5ESXg0MefFvBOqEa0bcQw+WtQk7X2hVaky1ccJPcZJMV0h8Dh+wsT06Jwu
X-Received: by 10.36.107.129 with SMTP id v123mr14037960itc.52.1463504619311;
 Tue, 17 May 2016 10:03:39 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Tue, 17 May 2016 10:03:38 -0700 (PDT)
In-Reply-To: <xmqqvb2dxomo.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294877>

On Mon, May 16, 2016 at 10:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>         int attr_match_nr;
>         int attr_match_alloc;
>         struct attr_match {
>                 struct git_attr *attr;
>                 char *value;
>                 enum attr_match_mode {
>                         ...
>                 } match_mode;
>         } *attr_match;
>         struct git_attr_check *attr_check;

ok, I'll use that structure and go from here.


>
> Then while parsing ":(attr:VAR1=VAL1 -VAR2 VAR3...)path/to/dir/",

This syntax is not pleasant to parse IMHO as it is not clear if the token
after white space (-VAR2 here) is another attribute or the next part of
the list of VAR1, i.e. this could also be:

    :(attr:VAR1=VAL1 VAL2)

I wonder if we'd want to use the colon to separate different VARs:

    :(attr:VAR1=VAL1 VAL2:-VAR2:VAR3)

which means:

   match all path, that
    * have VAR1 set to a value list containing at least
      VAL1 and VAL2
    * have VAR2 unset
    * have VAR3 set to true.
