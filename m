From: Chris Packham <judge.packham@gmail.com>
Subject: Question about .git/objects/info/alternates
Date: Mon, 22 Mar 2010 10:26:05 -0700
Message-ID: <a038bef51003221026i379ee16ej6e0e6defcf0048dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 22 18:26:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtlOH-0003nW-ON
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 18:26:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754768Ab0CVR0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 13:26:08 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:56555 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062Ab0CVR0G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 13:26:06 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1252507qwh.37
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 10:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=s9UgTOeBQgfOAJpykii2lXien6gFU5sHfBsPwoqeM90=;
        b=jlKhjb+XY0sT53xwiUGKMp9VmWE0eKh0ItPmQlhr0faS9HroWcCE8D7b8FgCCACK+L
         b+kaVVwcHFtqQAWs3aguaSDraFKR2AoICdzY+ETedpgpR20OzLEfud57FGHHd9HpTvCO
         GgrEQLyNjd26Momnuuh86BFK9xmdBKLXMs53M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=uIXiz7xyciq6aD0cxmc21oX7FWx29AABZYHqiEBp62LkFLziiRV3MaFwOzwG0zFh22
         TYxKdbvz3weQpuGSY8gwYW8fNPPksKpKDOIJIvHKica4onVSWf9a8QvWWGaq2Wq2ghMj
         H5zyO/YPIQj79ZA/2d4q6K0jO6YNKCGqnyVgc=
Received: by 10.229.218.203 with SMTP id hr11mr2007418qcb.85.1269278765363; 
	Mon, 22 Mar 2010 10:26:05 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142953>

Hi All,

I've been using git clone --reference and git submodule update
--reference to reduce the amount of data transferred when I cloned a
repository that I already had an older copy of (that for one reason or
another I didn't want to touch or clone directly).

Now I'm finding that what I really want to do is change around what is
referencing what. I currently have the following.

  projecta.git
  base.git       # references project a
  projectb.git  # referenced base (which, now that I think about it,
was probably the wrong thing to do)

Ideally I'd want to end up with
  base.git      # has all objects
  projecta.git # uses base as a reference
  projectb.git # uses base as a reference also

I would like to have base somehow find the objects it doesn't have in
its object store and either download them or just copy them from the
object store of projecta. Then I can manually point projecta at base
and repack (as discussed in this thread [1]) to free up some space.
projectb should be fine as is because it already references base. Is
there any way to actually do this? A little googling found hints on
adding alternates after the fact but I'm actually interested in going
the other direction. From reading [2] I think 'rm
.git/objects/info/alternates && git repack -a' might do the trick but
I'm not sure.

[1] http://thread.gmane.org/gmane.comp.version-control.git/141161/focus=141199
[2] http://stackoverflow.com/questions/2248228/how-to-detach-alternates-after-git-clone-reference
