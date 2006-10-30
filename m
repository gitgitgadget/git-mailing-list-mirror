X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC (take 2)] gitweb: New improved patchset view
Date: Mon, 30 Oct 2006 14:58:32 +0100
Message-ID: <200610301458.33634.jnareb@gmail.com>
References: <92622.251.qm@web31812.mail.mud.yahoo.com> <7vy7qyw6w6.fsf@assigned-by-dhcp.cox.net> <200610301043.22033.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 30 Oct 2006 14:00:02 +0000 (UTC)
Cc: Luben Tuikov <ltuikov@yahoo.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=jVpMxx0Y6pDTY7rPR8NoahzArr0eF4qZ/ycCpIFdYyg2X4gqcprA3/TMLGxB8FP0E8g5zfjbPh/nBlld3MWRrDhVSHnJY38t5QzbgR+E5qxHihYQZzIp/3VzKXWtb+d74UBsbNnXrwl3+t8ullLbC4W9RH8JTFl3oWmJxMRj5pw=
User-Agent: KMail/1.9.3
In-Reply-To: <200610301043.22033.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30499>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeXex-0001kv-W2 for gcvg-git@gmane.org; Mon, 30 Oct
 2006 14:58:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751651AbWJ3N6g (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 08:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751650AbWJ3N6g
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 08:58:36 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:40710 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1751175AbWJ3N6f
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 08:58:35 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1135543ugm for
 <git@vger.kernel.org>; Mon, 30 Oct 2006 05:58:34 -0800 (PST)
Received: by 10.67.105.19 with SMTP id h19mr4128697ugm; Mon, 30 Oct 2006
 05:58:32 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id o1sm2830973uge.2006.10.30.05.58.29; Mon, 30 Oct
 2006 05:58:29 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Jakub Narebski wrote:
> Junio C Hamano wrote:
>>
>> I think the UI layer like gitweb should have freedom to choose
>> its own pathname handling, and should read from -z output.
> 
> That's a very good idea. I'll send separate patch (if noone else will
> do this, that is) which would convert gitweb to always use -z output,
> both git-ls-tree and git-diff-tree... oh, well, there is no -z patch
> output, so in patch part we would have to replace git quoted part by
> gitweb quoted part.

I have realized that it is not as easy as it sounds, at least for the
git-diff-tree output. For the LF-terminated output (without '-z') you
know that LF separates records, and you can split on LF ('\n'). It is
not the case for '-z' '\0' delimited output: NUL ('\0') might also mean
end of one of the filenames in the rename/copy case, and is used to 
separate filename(s) from the score (although here TAB would be 
enough). And that is probably the case that gitweb uses default 
git-diff-tree output, and _tries_ to unescape(...) filename.

The solution would be perhaps to add '--zz' option to use '-z' output 
but to separate records by double NUL, i.e. '\0\0'...

By the way, why diff-tree "raw" format for merge gives only one, final,
filename?
-- 
Jakub Narebski
