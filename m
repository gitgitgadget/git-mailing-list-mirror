From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: Leaving large binaries out of the packfile
Date: Fri, 11 Jun 2010 17:29:50 +0200
Message-ID: <4C12566E.6020607@gnu.org>
References: <4C108556.8040102@workspacewhiz.com> <20100610180457.GO14847@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jun 11 17:30:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ON6BO-0008TG-Bk
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 17:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756376Ab0FKP35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jun 2010 11:29:57 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53368 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756343Ab0FKP3z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 11:29:55 -0400
Received: by wyb40 with SMTP id 40so873340wyb.19
        for <git@vger.kernel.org>; Fri, 11 Jun 2010 08:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=gepc0SkZwJnTeQhAWJapPxm4W8am20HstnQQI5YM+oo=;
        b=rEN0K3eoWYSUGqyNLVeYPVWaz3B3m2sT31Xgypo5Y1e+OCWdZXJebmIPYj4Vnuqitz
         CTmHZIQwurbiatirfQfI0LRvt9ieBUMwD5Ya3Q+p0UdoMCC8r2CWe30dBoucLUs7hOGM
         HCRRFUIOdqaEeCIGCVZMAtg3O0vEoLpdLtsRw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=LOmAvsDNgARaccFytyhAwIWOmuNDqko1l/Tn+SLUU7bONjrUjHhO5520ujXcQQNIYs
         6y+MFp+HHWFh+lTCal8Bdpj1rDOC+DCN7hIINY/4l5pOayuDP8Qmnakx9Yef/6u/e0Gr
         dhLFa/lXHpERtQ3IRwMbWGfStzgpaX+1HzCGU=
Received: by 10.227.138.148 with SMTP id a20mr2068177wbu.91.1276270193635;
        Fri, 11 Jun 2010 08:29:53 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-brq-t.redhat.com [209.132.186.34])
        by mx.google.com with ESMTPS id b17sm10032642wbd.1.2010.06.11.08.29.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 11 Jun 2010 08:29:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-3.fc13 Lightning/1.0b2pre Thunderbird/3.0.4
In-Reply-To: <20100610180457.GO14847@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148955>

On 06/10/2010 08:04 PM, Shawn O. Pearce wrote:
> Joshua Jensen<jjensen@workspacewhiz.com>  wrote:
>> Sometimes, 'git gc' runs out of memory.  I have to discover which file
>> is causing the problem, so I can add it to .gitattributes with a
>> '-delta' flag.  Mostly, though, the repacking takes forever, and I dread
>> running the operation.
>
> If you have the list of big objects, you can put them into their
> own pack file manually.  Feed their SHA-1 names on stdin to git
> pack-objects, and save the resulting pack under .git/objects/pack.

Do you know any simpler way than

git log --pretty=format:%H | while read x; do
   git ls-tree $x -- ChangeLog | awk '{print $3}'
done | sort -u

to do this?  I thought it would be nice to add --sha1-only to 
git-ls-tree, but maybe I'm missing some other trick.

> Assuming the pack was called pack-DEADC0FFEE.pack, create a file
> called pack-DEADC0FFEE.keep in the same directory.  This will stop
> Git from trying to repack the contents of that pack file.
>
> Now run `git gc` to remove those huge objects from the pack file
> that contains all of the other stuff.

That obviously wouldn't help if these large binaries are updated often, 
however.

Paolo
