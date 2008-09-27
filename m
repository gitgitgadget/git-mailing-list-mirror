From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git log and utf-u in filenames
Date: Sat, 27 Sep 2008 10:37:12 +0200
Message-ID: <200809271037.13571.jnareb@gmail.com>
References: <20080925215002.GA30810@kodama.kitenet.net> <200809260931.21883.jnareb@gmail.com> <81b0412b0809260649n7d7c0ccbwfde5504157687cda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Joey Hess" <joey@kitenet.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 27 10:38:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjVJz-000340-2U
	for gcvg-git-2@gmane.org; Sat, 27 Sep 2008 10:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948AbYI0IhZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Sep 2008 04:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751945AbYI0IhZ
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Sep 2008 04:37:25 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:26536 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbYI0IhY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2008 04:37:24 -0400
Received: by fg-out-1718.google.com with SMTP id 19so873663fgg.17
        for <git@vger.kernel.org>; Sat, 27 Sep 2008 01:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=pGyxChaF+7kHUKp5nfc0XaYduUoQOZp98IGKZ6M5y1w=;
        b=WqOXSoJONp1MPTVfAT6P8AqD06mava7fdmH1DdQuDxx8Ej2tsUMgbQEP/HTpJE3IHR
         6f4J3AH4JfgLxEPfOWUNbA6E/Dp5328rRhTxPGuOo4VnD5qcKX549jcQ3qEQpqW9pfG6
         K6ET1anoriUatB3/170PeBJRUN3/p64Dn/u58=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=iKaXB2tlhRBSLoFkUVZWE0KcufWZLz0nAoZ9cWMTWLkdcQzlY1JIUl+UDMY8GP1xCj
         sYuAevbVSZZFhZdgWX2iJDK9yoyvptLvIKq8o752CCZNRAxb9oPpUnyDNRzoSPCIU78M
         mB1ReASRf1EZhRAYMQxn5Rfc92FPDTHpN812k=
Received: by 10.86.80.17 with SMTP id d17mr2076141fgb.47.1222504639722;
        Sat, 27 Sep 2008 01:37:19 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.218.9])
        by mx.google.com with ESMTPS id 4sm5690907fgg.4.2008.09.27.01.37.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Sep 2008 01:37:18 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <81b0412b0809260649n7d7c0ccbwfde5504157687cda@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96904>

On Fri, 26 Sep 2008, Alex Riesen wrote:
> 2008/9/26 Jakub Narebski <jnareb@gmail.com>:

>>> How about simply splitting output on end of line ("\0" NUL) characters?
>>> The "\n" NL you refer to is just as EOR as NUL.
>>
>> Doesn't work for "git diff-tree -z [...]" output. When there is rename
>> or copy detected, NUL is used as separator between fields (beetween
>> source and destination unquoted filename), not only between records:
>>
>>  git diff-tree
>>      .... <src qfilename> TAB <dst qfilename> LF
>>
>>  git diff-tree -z
>>      .... <src filename>  NUL <dst filename>  NUL
>>
> 
> You still have the marker (Rnnn) from pre-<src filename> record and
> can treat the next record correspondingly. Still a split, just a bit more
> careful handling of the resulting list/array.

Currently gitweb does something like this:

  open $fd, "-|", git_cmd(), "diff-tree", '-r', ...
  @difftree = <$fd>;
  close $fd;
  foreach my $line (@difftree) {
     ...
  }

If gitweb would use git-diff-tree with '-z' option, above code
would get more complicated, offsetting simplification of not using
unquote() (which is already written).

-- 
Jakub Narebski
Poland
