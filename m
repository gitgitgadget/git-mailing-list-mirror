From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4] fast-import: treat filemodify with empty tree as
 delete
Date: Thu, 27 Jan 2011 13:48:45 -0600
Message-ID: <20110127194844.GA20894@burratino>
References: <1291286420-13591-1-git-send-email-david.barr@cordelta.com>
 <20110103080130.GA8842@burratino>
 <20110103082458.GC8842@burratino>
 <20110126224104.GA20388@burratino>
 <AANLkTimNWLFgTk0Bueiscw-WkAX53v0Xsepn9esXOt7+@mail.gmail.com>
 <20110126230608.GA26787@burratino>
 <7vd3nji54o.fsf@alter.siamese.dyndns.org>
 <20110127060749.GA5586@burratino>
 <20110127193353.GA19378@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <david.barr@cordelta.com>
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 27 20:49:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiXq2-0003YV-2E
	for gcvg-git-2@lo.gmane.org; Thu, 27 Jan 2011 20:49:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752485Ab1A0Ts5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jan 2011 14:48:57 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:36499 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648Ab1A0Ts4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jan 2011 14:48:56 -0500
Received: by wwa36 with SMTP id 36so2554024wwa.1
        for <git@vger.kernel.org>; Thu, 27 Jan 2011 11:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=USs9/C6s6SZH3R3qtuVgyD4iDLFzs1ERCVbpQpl2aBI=;
        b=VllytmMaQCue7edfFIlwWyzCXnnTGYW1hlobd6DS2Cd9F7yqlMtMMIDX0S8/3ED8rP
         aQ1ZMfYmeE75Ry5pj8kqfxB7ZLcXNvs3hBxR73bTWc3iRuf+ELTefbJJYlQE0s2q8Q5X
         i6nPODzV+eXmjdrHpzgpypmfsjKswet3e4pj0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dkZNmuH5ATlLMqlICAVlPQpQRRXg5ZLflUM30kSmUk0d01cflUDu7jU8UxgWgO/Avu
         5ceEW/Ol+JafAQ2bGv91rMRmleELJN5LxNgAvbSif8wfAG6z8F2uvs0qpRRsurf6KW/n
         6JxfNoA7QyZN9T1lrcSnsvkcJZ7XP47PRuNCk=
Received: by 10.227.143.206 with SMTP id w14mr1607157wbu.66.1296157735205;
        Thu, 27 Jan 2011 11:48:55 -0800 (PST)
Received: from burratino (adsl-69-209-75-28.dsl.chcgil.ameritech.net [69.209.75.28])
        by mx.google.com with ESMTPS id o6sm408169wbo.3.2011.01.27.11.48.52
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 27 Jan 2011 11:48:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110127193353.GA19378@m62s10.vlinux.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165587>

Peter Baumann wrote:
> On Thu, Jan 27, 2011 at 12:07:49AM -0600, Jonathan Nieder wrote:

>> +++ b/t/t9300-fast-import.sh
>> @@ -818,6 +818,48 @@ test_expect_success \
>>  	 compare_diff_raw expect actual'
>>  
>> +test_expect_success \
>> +	'N: delete directory by copying' \
>> +	'cat >expect <<-\EOF &&
>> +	OBJID
>> +	:100644 000000 OBJID OBJID D	foo/bar/qux
>> +	OBJID
>> +	:000000 100644 OBJID OBJID A	foo/bar/baz
>> +	:000000 100644 OBJID OBJID A	foo/bar/qux
>> +	EOF
>> +	 empty_tree=$(git mktree </dev/null) &&
>
> [ Feel free to ignore me ... ]
>
> Just a (stupid?) suggestion: Why not put a $EMPTY_TREE definiton in test-lib.sh
> (or any other global file sourced in the tests) so if another caller needs this
> definition it won't waste cpu cycles doing the calculation via mktree < /dev/null
> again?

Might be a good idea.  Note, though, that that would mean more cpu
cycles used rather than less, unless we hardcode the object name
(which I prefer not to do).

One possibility would be a lib-object-names.sh defining EMPTY_BLOB and
EMPTY_TREE to be sourced by tests that need it.
