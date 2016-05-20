From: Kevin Harrington <mad.hephaestus@gmail.com>
Subject: BowlerStudio: using GIT as a file system for distributed robots
Date: Fri, 20 May 2016 13:55:13 -0400
Message-ID: <CAASPp8+x01E5W3cLiLNaXM6KMHVGTE0owZ4vFk97vKAZ3Z3yzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 19:55:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3oeA-00048k-RI
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 19:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbcETRze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 13:55:34 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38115 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbcETRze (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 13:55:34 -0400
Received: by mail-wm0-f48.google.com with SMTP id n129so93016313wmn.1
        for <git@vger.kernel.org>; Fri, 20 May 2016 10:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=Ich/l4FvgN04l4MQrlmOmoNRgwsKvybUGewj9/I+Dus=;
        b=CidTidDcXihztVlf/L631j5vNDeJUmxv8subVgYWFnrfhZCFTp7Bxqfke4gDu3S3FH
         IcrjyVjcfjYsREIEq50XVOno7t1d0zIiQlDIXx+HNvnmlFj5N11q7b5KZw/qQ+Vm2oaT
         vDDdOTybWiOm1E+8I2cqFWexAZ0pYFo8s2nqvTJ3zrzdRRdAJHNpVO/SKV7AzItaBbWV
         5UOTGPcI6EFosrfhlWcWr8prRbNlxi4Z7cIYB51F9Oc9ekCXqCcntvr7xiqtN7n4ARmg
         18uideWX3htWHDwlqbZcNjw7dMjqdtl6iQvPP0aysRKCFxb5+1txC0y7lH1BFU0mX8xD
         +yeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Ich/l4FvgN04l4MQrlmOmoNRgwsKvybUGewj9/I+Dus=;
        b=FhsZ7j8k8VDlroHBpZotQoOfsZoC6ZpPOJKsy3FRhI886VhGJ/znWO+dAMeoi93t/K
         m0rfmoHB3JExPjvDUWQBXJGZ39YYyJHTe8w9o2YaqOgF48lgRalQRMcPv6dNlA/UogXb
         ofqAHB+tD8lIye7xVlHKuyFGfGYMuLUFcZXFKW+exYEH8Ymh3Dw7GQ7Agd+HZ09+oouR
         XXZyNwRyI3vsVvdKq61HrLN5u6siwPqGCq4NEcdYvF5GK5Je+rniRXuRHJQ70ob/0sVG
         HKlofbHw5rwKluwo4jxznnD4/ptwU0GkaipmNLEhVnJAkZdj+0AaRTmIkwRcRBldwpVZ
         9kqQ==
X-Gm-Message-State: AOPr4FW8/E44SrSmsuZhAGxMMi/Uijqbl995irtckN6idwl7xn6bOxHaP81ZjBD6VrAbRkpPZrAKL9ZZGrxTSQ==
X-Received: by 10.28.144.11 with SMTP id s11mr4785566wmd.72.1463766932574;
 Fri, 20 May 2016 10:55:32 -0700 (PDT)
Received: by 10.28.234.141 with HTTP; Fri, 20 May 2016 10:55:13 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295194>

I have spent the past year building an new open source robotics
development platform and wanted to show you fine folks working on Git:

BowlerStudio: https://github.com/NeuronRobotics/BowlerStudio

I started working a set of robotics control libraries back in 2009 and
have deployed them as the control framework for MRI compatible robots.

Over the past year i began developing a set of tutorials for building
robots using my framework. In this process i build a small scripting
engine that uses Git as its file system. This allows scripts to
hyperlink to each other based on the Git repository they live in.

The platform supports Java/Groovy, Clojure, and Python scripts, and
these scripts use an "Object in Object out" version of the Pipe
pattern for interfacing. Since the JVM provides the common runtime,
they can pass memory references back and forth in the pipe pattern as
opposed to parsing and building stings. This lets any of the languages
trivially interoperate together. If a script you want is in a
different langauge hosted on a different Git repo, no problem just
call it in line and the compiled and typed object is returned.

Under the hood, JGIT, the same library eclipse uses to provide Git
support, is the library that manages the local caches of files pulled
from the Git repo. The scripting engine has features to commit changes
and push them upstream. In the Tutorials, you look at spike examples
in the WebBrowser (using GitHub Gist to JS embed the code), JGIT takes
the Git URL extracted from the Gist, caches the repo to the disk, and
makes it availible to the new user to run. From there the user can
fork, modify, and publish changes to the demo code. In this way, all
examples are executable right out of the built in browser for the
fastest startup time with new code examples.

The Application is used to connect cameras, robot controllers,
kinematics libraries, CSG Cad engine, a physics engine and a few AI
libraries all in a common runtime with a shallow on-ramp for even
novice programmers.

TL;DR Kerbal Space Program meets ROS on the JVM using Git as a filesystem
