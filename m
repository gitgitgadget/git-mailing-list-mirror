From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH JGIT] Ensure created test repositories use canonical paths
Date: Fri, 21 Aug 2009 23:32:59 -0400
Message-ID: <2c6b72b30908212032t39a4896x3308148c44692a80@mail.gmail.com>
References: <1250687891-17916-1-git-send-email-fonseca@diku.dk> 
	<200908210035.10825.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sat Aug 22 05:33:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MehM8-0007H4-5X
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 05:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933211AbZHVDdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 23:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933209AbZHVDdS
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 23:33:18 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:12884 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933207AbZHVDdR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 23:33:17 -0400
Received: by qw-out-2122.google.com with SMTP id 8so716489qwh.37
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 20:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=4dmrceXSYtUJB1iSB88EwXSSUzVtDbNb0bh44AotD2Y=;
        b=lZwPJ+qW1e1ldnaV88LkBhlKw+gmyHkb3+1S6Ik2OqegD7Z9e16EmIbJB0+raL4Gq/
         C0IiRrrUU7hUoF5XKBV0+oHeMfEL7XceimHpGYw23a5T+rFIeOzQdWgOq0ZZ1QwSgHy/
         8rYgieqjN36vZbc2pqB3eoM7sofH+szpGTfkE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=r88ZiFwz/1sE25yYwAyLjgDM6VROWNdREyYTD0rje0g7mInLRpk7cL4txYjEj/YTdJ
         9CErbYqGQ09iuOKcTfvBEMoYU9y9sFhRWbg8rSvoc/1oYGQi0qNeoeaUD1mFQgijsq51
         mp+I8IoLJpRlVdMjUgMHH29VZ5D3CSdloyQcw=
Received: by 10.224.36.139 with SMTP id t11mr1321570qad.350.1250911999061; 
	Fri, 21 Aug 2009 20:33:19 -0700 (PDT)
In-Reply-To: <200908210035.10825.robin.rosenberg.lists@dewire.com>
X-Google-Sender-Auth: 8d99792820778873
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126780>

[With correct CC list. Sorry for the resend Robin]

On Thu, Aug 20, 2009 at 18:35, Robin
Rosenberg<robin.rosenberg.lists@dewire.com> wrote:
> onsdag 19 augusti 2009 15:18:11 skrev Jonas Fonseca <fonseca@diku.dk>:
>> Fixes breakage in the RepositoryCacheTest when running tests using:
>>
>>       mvn -f ./jgit-maven/jgit/pom.xml test
>> [...]
>> @@ -217,7 +217,7 @@ public void setUp() throws Exception {
>>               trash = new File(trashParent,"trash"+System.currentTimeMillis()+"."+(testcount++));
>> -             trash_git = new File(trash, ".git");
>> +             trash_git = new File(trash, ".git").getCanonicalFile();
>> @@ -307,7 +307,7 @@ protected Repository createNewEmptyRepo() throws IOException {
>>       protected Repository createNewEmptyRepo(boolean bare) throws IOException {
>>               final File newTestRepo = new File(trashParent, "new"
>>                               + System.currentTimeMillis() + "." + (testcount++)
>> -                             + (bare ? "" : "/") + ".git");
>> +                             + (bare ? "" : "/") + ".git").getCanonicalFile();
>
> We use getCanonicalFile here and Repository.gitDir  is initialized with getAbsoluteDir.

BTW, a simpler fix would be to initialize trashParent to a canonical
path, which might be less intrusive.

> Does this work on all platforms?

I have only tested on Linux.

> Seems linux normalized things when you do things like, but I'm not sure that happens everywhere.

If you think it is a problem, let's drop the patch. It just seemed
like a simple way to increase robustness.

--
Jonas Fonseca
