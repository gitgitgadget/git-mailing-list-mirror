From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: [JGIT RFC] How read versions of a specific object
Date: Wed, 7 Jan 2009 09:44:05 +0600
Message-ID: <7bfdc29a0901061944x454a9t1d01e6744f08cf78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 07 04:46:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKPMz-0004DH-4s
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 04:46:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916AbZAGDoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 22:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751838AbZAGDoJ
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 22:44:09 -0500
Received: from rn-out-0910.google.com ([64.233.170.185]:32591 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbZAGDoI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 22:44:08 -0500
Received: by rn-out-0910.google.com with SMTP id k40so5590740rnd.17
        for <git@vger.kernel.org>; Tue, 06 Jan 2009 19:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=M2mrT/96ozrQ3Q7f5/zYumaM4ra57eea0vNlmZArywk=;
        b=Sw8KceS1nFcPQvWtMYCVc+ec97PKg6NiVDYPceLbpiQ57tbu0J5qYFY00tczzp835V
         OhHSILors2wBNPdrI6liqgEZo6gHjY1kiSLxN+cYonI35OzqP6URREnTqPi4VOm75bqG
         xuq2GUDecRLwwBNPohWLnmQW/iUSVDYC2B25Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=wMQ8QrtCTr/tV5WrKi/6dBnHEbbeOIaUOmHZrqLLdzay5Ope9mRHVXqtk5ZkRL4Hcu
         V3Jw5504JFVXM3WNPnoXbp/I+aJ7gHCL1Ql5bsGQK8K0FTYROC2CEyJ9QzMH3MrtNmK6
         4+BiVkYpl8Nax8zZzXS2RaQfVqzNhJxzVkHCs=
Received: by 10.151.12.1 with SMTP id p1mr25219121ybi.112.1231299845834;
        Tue, 06 Jan 2009 19:44:05 -0800 (PST)
Received: by 10.150.229.15 with HTTP; Tue, 6 Jan 2009 19:44:05 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104751>

Hi,

I am trying to read all or n-th version of an object. Currently to do
this I am using the following piece of code, which has to walk to
every commit is present and from there prepare a set of its object id,
it is definitely expensive if the commit history is huge, is there a
faster/better way to achieve it?

for (int i = 0; i < App.OBJECT_COUNT;
            ++i) {
            System.out.println("INDEX: " + i);
            String isbn =
                String.valueOf(Integer.parseInt(App.INIT_ID) + i);
            System.out.println("ISBN: " + isbn);
            ObjectWalk objectWalk = new ObjectWalk(repo);
            /*
             * Checks whether the Commit has the tree or not. It does not
             * check whether it has changed or not.
             */
            objectWalk.setTreeFilter(PathFilter.create(isbn));
            RevObject revObject = null;
            objectWalk.markStart(objectWalk.parseCommit(repo.resolve(
                Constants.HEAD)));
            Set<ObjectId> revisions =
                new HashSet<ObjectId>();
            do {
                if (revObject != null) {
                    Commit revision = repo.mapCommit(revObject.getId());
                    Tree versionTree = repo.mapTree(revision.getTreeId());
                    if (versionTree.existsBlob(isbn)) {
                        revisions.add(versionTree.findBlobMember(isbn).getId());
                    }
                }
                revObject = objectWalk.next();
            }
            while (revObject != null);
            System.out.println("Revisions: " + revisions);
        }

The details source code of the project is available @
http://github.com/imyousuf/jgit-usage/tree/master

Thank you,

-- 
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Blog: http://imyousuf-tech.blogs.smartitengineering.com/
Mobile: +880-1711402557
