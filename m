From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] cvsserver: Make always-binary mode a config file option
Date: Thu, 1 Mar 2007 09:41:16 +0000
Message-ID: <200703010941.20161.andyparkins@gmail.com>
References: <7v4ppedj3r.fsf@assigned-by-dhcp.cox.net> <200703010840.54377.andyparkins@gmail.com> <46a038f90703010113o256f19a2qb1c16f4c85e5bd1c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Martin Langhoff" <martin.langhoff@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 01 10:41:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMhmw-00077n-Lb
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 10:41:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933227AbXCAJl0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 04:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933235AbXCAJl0
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 04:41:26 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:15809 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933227AbXCAJlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 04:41:25 -0500
Received: by nf-out-0910.google.com with SMTP id o25so838154nfa
        for <git@vger.kernel.org>; Thu, 01 Mar 2007 01:41:23 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Rff9hHRrDlXx9o9z/+jA48fXaqJ5zop5iXoykiotaw0XfxuCx6rUMjeDFfFiCdbExImjRzoltdlfTKbX2e47+sOXudpFqk1KgaxwyOHYxw5eHRe/eZr1kKuQHsRwsBRjdFlW814eXzi4REuYIgGdmWEfLhtbO6I5czpAqU/ZZE8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=NaHai1bpi47uRRpmniFLK4wa8BrFCLl/KX953tA5cHpBtvlxRZn278kcH+ytI0aFu+/sdmRGD/uaBiu0mOtKeQUVTjUULIYF6oXjcRv2HKutP2q3ZohFdlgGGnJy9Cn1iNndI79TehDe5favjzfyxNbDji07pF4rQ+2pNepwepA=
Received: by 10.49.13.14 with SMTP id q14mr5307576nfi.1172742083880;
        Thu, 01 Mar 2007 01:41:23 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id q28sm8460658nfc.2007.03.01.01.41.21;
        Thu, 01 Mar 2007 01:41:22 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <46a038f90703010113o256f19a2qb1c16f4c85e5bd1c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41069>

On Thursday 2007 March 01 09:13, Martin Langhoff wrote:

> Well... the guys working on the MinGW port of git have railroaded us
> with the opposite position. If it's going to work in Windows, you
> better accept it has to handle newline conversion correctly or it's
> broken...

I do accept that, but as you said - it's broken whether you pick all binary or 
all text.  I'm not advocating that my solution is final, but it is better to 
not convert text than to mangle binary.

> The interesting case to fix this for is a mixed binary and text repo
> with windows users wanting newline conversion (if they really don't,
> they can tell TortoiseCVS as much). For that scenario, current
> behaviour is broken (binaries get mangled), and setting -kb on
> everything breaks newline conversion.
>
> And that scenario can only be addressed sending appropriate flags for
> each file, not with a blanket switch.

Erm, yes, I know that.  But who is going to set that switch?  This isn't real 
CVS where the repository records that information.  At the moment git does 
not know whether any given file is binary or text.

> Except that it's not that hard to do something better -- I was hoping
> to prep a patch today, but things got frantic at the office.

I think it is hard; as git doesn't supply the needed information.  I suppose 
it could be stored in the SQLlite table, but that is seriously borked.  That 
table is a necessary evil, not a place to start storing any old flag.

> Just that I think it's easy enough to implement something that sets
> -k mode on file extension, which is actually _much_ better and makes
> the blanket setting pointless. And perhaps we can get binary
> autodetection working well but accepting overrides.

As I said, I don't like autodetection.  It /will/ get it wrong.  As for using 
file extension - well that's wrong too if it's coded into the source.

In a previous life, I used to develop a unix program on a windows computer; 
the UNIX directory was mounted as a samba share and built and run via an ssh 
connection.  How is git-cvsserver meant to know about a crazy situation like 
that and "auto-detect" the right thing?  It can't.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
