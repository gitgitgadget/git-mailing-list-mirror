From: "Kelly F. Hickel" <kfh@mqsoftware.com>
Subject: RE: git fast-import problem converting from CVS with git 1.6.1 and cvs2svn 2.2.0
Date: Thu, 22 Jan 2009 08:30:39 -0600
Message-ID: <63BEA5E623E09F4D92233FB12A9F794302BC6921@emailmn.mqsoftware.com>
References: <63BEA5E623E09F4D92233FB12A9F794302BC6851@emailmn.mqsoftware.com> <63BEA5E623E09F4D92233FB12A9F794302BC6855@emailmn.mqsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "Kelly F. Hickel" <kfh@mqsoftware.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 22 15:32:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ0bH-0005Hi-96
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 15:32:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbZAVOan (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 09:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbZAVOam
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 09:30:42 -0500
Received: from emailmn.mqsoftware.com ([66.192.70.108]:54743 "EHLO
	emailmn.mqsoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507AbZAVOam convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jan 2009 09:30:42 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <63BEA5E623E09F4D92233FB12A9F794302BC6855@emailmn.mqsoftware.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git fast-import problem converting from CVS with git 1.6.1 and cvs2svn 2.2.0
Thread-Index: Acl7FlA+C4XwNB8tTcebTogzddVJxAAAldoQAGEiwEA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106753>

(Sorry for the mangled quotes)

> That is strange.  The command "data 88" should read the next 88 bytes
and 
> not stop at the line starting with '. 
> 
> Just to test, I successfully imported this: 
> 
> -- snip -- 
> commit refs/heads/testing/test 
> mark :1 
> committer cvs2svn <cvs2svn> 1002043747 +0000 
> data 3 
> '. 
> 
> -- snap -- 
> 
> So I guess the problem lies much earlier: I could imagine that there
is 
> _another_ "data" command that has a bogus length and just happens to
end 
> after the line "data 88". 
> 
> Maybe that helps? 
> 
> I could also imagine that the '. actually is the end of an example 
> inside a blob, that literally looks like a fast-import script, but 
> actually is not meant for _this_ fast-import run. 
> 
> Ciao, 
> Dscho 
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe git" in 
> the body of a message to majordomo@... 
> More majordomo info at  http://vger.kernel.org/majordomo-info.html 


> 
> From: Daniel Barkalow 
> Can you find that part of the input? I wouldn't be too surprised if 
> something were giving the wrong length in a data command, causing it
to 
> either eat another data command and end up in the data or to use 
> not-quite-all of the data and end up near the end of the data. 
> 
>         -Daniel 
> *This .sig left intentionally blank* 
> 
>

I found the section in question, it is:
-- snip --
commit refs/heads/TAG.FIXUP
mark :1000007128
committer cvs2svn <cvs2svn> 1002043747 +0000
data 88
This commit was manufactured by cvs2svn to create tag
'T_BU_Problem_9xxx_Merge_3-21-2000'.
merge :1000007126
M 100755 :180810 mfcdev/Domedit/DlgAddAlias.h
-- snap --

By my count, 88 is the ending single quote character, leaving the '.' to
be interpreted as a command.

Looks like I should go post this on the cvs2svn list.....


Thanks!


--
Kelly F. Hickel
Senior Product Architect
MQSoftware, Inc.
952-345-8677 Office
952-345-8721 Fax
kfh@mqsoftware.com
www.mqsoftware.com
Certified IBM SOA Specialty
Your Full Service Provider for IBM WebSphere
Learn more at www.mqsoftware.com 
