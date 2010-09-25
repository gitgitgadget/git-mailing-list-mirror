From: Artur Skawina <art.08.09@gmail.com>
Subject: git-show-merge-path v2.0
Date: Sat, 25 Sep 2010 23:03:30 +0200
Message-ID: <4C9E63A2.9040204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Seth Robertson <in-gitvger@baka.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 25 23:03:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzbuP-0008BE-KW
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 23:03:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756909Ab0IYVDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 17:03:36 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:55292 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756789Ab0IYVDf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 17:03:35 -0400
Received: by ewy23 with SMTP id 23so1013033ewy.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 14:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:x-enigmail-version:openpgp
         :content-type:content-transfer-encoding;
        bh=lh7YmBYR2JON1SlY68xyFrnQPE7UQ0Hk65lye3LUdrE=;
        b=ZlgTyhnK+V8fw7KBIGe7H0CJY5Knt/mVQr75ympfUi6tetQptYU7Sb3hu2Rvb2zN4P
         4WHUYA2m4uP4vWmhXtW9exLmTIFCrJ17p57uVs/P+7oCflwyLRc8Q75xBWysgHt13KEO
         OuTqr3jlU9A5rogJuGJlVhKIfLMt1jdxhiLJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        b=M2blpRwX36DFQ+cnLGjB0KZsr5Zi+wZhlWPuPkItV2V0BQvgCVqZOxnQ0PV2bssx3T
         uuA89RvT41VXBYVlr6EWTB5UeCSVRyDgeejXEM4ZHVOWcpnmqi6RDwfMyu5dSbZejlvO
         3hcRb1yylTudOwi2ORh1aOKLP1HVEUhtqeF8g=
Received: by 10.213.104.203 with SMTP id q11mr1532946ebo.12.1285448613934;
        Sat, 25 Sep 2010 14:03:33 -0700 (PDT)
Received: from [172.19.43.221] (ip-89-174-83-200.multimo.pl [89.174.83.200])
        by mx.google.com with ESMTPS id z55sm5509755eeh.3.2010.09.25.14.03.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Sep 2010 14:03:33 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.9pre) Gecko/20100819 Lightning/1.0b2 Lanikai/3.1.3pre
X-Enigmail-Version: 1.1.1
OpenPGP: id=DDEB1C43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157201>

I thought i was done with this thing, but decided to add the experimental
fastforward detection, and while doing that also fixed a lot of corner
case bugs, which didn't appear when testing on real repos. Like breaking
w/ used in repos that have no annotated tags or reporting that a commit is 
unreachable, when in fact the branch head points at it.

The one new experimental feature is the FF detection.

It received little testing and is off by default.
For the artificial "fake" repos, it puts every single commit on the
correct branch. In practice i guess it depends on how creative people
get and if there's some, preferably hook-enforced, policy in place.

Is it useful? Well, I'm not sure yet, here are some examples:
[s/origin/heads/ if that's where your master/next/maint etc lives]
[all of these cmds show just one merge if ran w/o '-g']

$ git-show-merge-path 442b3caaee origin 
f4198c9b7d31 M: 'master'@git://repo.or.cz/git-gui                   080316 06:07
          \_ Appears in HEAD, maint, master, next and pu [v1.5.4.4-616-gf4198c9]
             Not reachable from html, man and todo

$ git-show-merge-path 442b3caaee origin -g
442b3caaee6d                                                        
          \_ Appears in master [gitgui-0.9.3-33-g442b3ca]
f4198c9b7d31 M: 'master'@git://repo.or.cz/git-gui                   080316 06:07
          \_ Appears in HEAD, next and pu [v1.5.4.4-616-gf4198c9]
319a36a5c2da M: 'maint'                                             080327 20:35
          \_ Appears in maint [v1.5.5-rc1-21-g319a36a]
             Not reachable from html, man and todo

$ git-show-merge-path 1b6ecbad3511 origin -g
1b6ecbad3511                                                        
          \_ Appears in maint [v1.7.2.3-8-g1b6ecba]
8ac8cf5bc17e M: 'maint'                                             100910 00:29
          \_ Appears in HEAD, master, next and pu [v1.7.3-rc0-35-g8ac8cf5]
             Not reachable from html, man and todo
	     
$ git-show-merge-path 4ce6fb805803 origin -g
9f44723d1a2c M: 'en/d-f-conflict-fix'                               100908 15:54
          \_ Appears in HEAD, master, next and pu [v1.7.3-rc0-8-g9f44723]
5879b6bbcaba M: 'maint'                                             100912 20:53
          \_ Appears in maint [v1.7.3-rc1-4-g5879b6b]
             Not reachable from html, man and todo


It can easily get confused, and i didn't even bother to tweak the heuristic
to fix specific cases (like 'master' being somewhat special).
That's why this is off by default and needs to be explicitly turned on ("-g").
Always run the script w/o '-g' and only turn it on to get a more detailed, but
possibly misleading view later.


Then, there's the hidden easter egg enabled by '-g2'. Added while writing this
email, so you can imagine just how much testing it has received...
This mode works best when you request only refs that are all reachable from
the commit in question, as this will prevent uninteresting merges (past the
real merge point) from being shown. (IOW pick one of the refs printed after
the last merge point shown w/o '-g2')

$ git-show-merge-path 1b6ecbad3511 origin/master -g2
1b6ecbad3511                                                        
          \_ Appears in $dr/maint-ls-tree-prefix-recursion-fix and $maint [v1.7.2.3-8-g1b6ecba]
8ac8cf5bc17e M: 'maint'                                             100910 00:29
          \_ Appears in master [v1.7.3-rc0-35-g8ac8cf5]


$ git-show-merge-path d5675bd204e heads/master    
8bd39456bd5a M: 'vhost-net'@$KO/mst/vhost                           100703 05:29
597e608a8492 M: 'master' of $KO/davem/net-2.6                       100707 22:59
2aa72f612144 M: $KO/davem/net-2.6                                   100708 02:56
          \_ Appears in master [v2.6.35-rc4-86-g2aa72f6]

$ git-show-merge-path d5675bd204e heads/master -g2
d5675bd204ef                                                        
          \_ Appears in $vhost-net [v2.6.35-rc1-140-gd5675bd]
8bd39456bd5a M: 'vhost-net'@$KO/mst/vhost                           100703 05:29
          \_ Appears in $davem/net-2.6 and $master [v2.6.35-rc1-182-g8bd3945]
597e608a8492 M: 'master' of $KO/davem/net-2.6                       100707 22:59
          \_ Appears in $davem/net-next-2.6, $for-davem and $vhost-net-next [v2.6.35-rc1-1020-g597e608]
2aa72f612144 M: $KO/davem/net-2.6                                   100708 02:56
          \_ Appears in master [v2.6.35-rc4-86-g2aa72f6]

So it can sometimes be used to easily dig out a little bit more info,
w/o having to look at the rest of the history.

Amazingly enough, this thing can still be almost twice as fast as the
equivalent "git tag --contains". And I thought git was fast. :^)

artur
---------------------------------------------------------------------------------
#! /usr/bin/env pike
// git-show-merge-path <rev> [refs-glob ...]
// v2.0
// Will show all external merge commits starting at <rev> until
// this commit appears on the specified branches. When that happens
// "Appears in <branchlist>" is printed. If <rev> is still
// unreachable from some of the branches then the search continues.
// If at least one of the branches does not contain <rev> then $0
// can and will print *all* merges (ie it won't stop at the last
// of the given branches containing this commit), followed by 
// "Not reachable from <branchlist>". This is a feature (can be
// used to find leaks outside of the given branches).
//
#define die(a...) exit(1, "Aborting; %s"+a)

static mapping commits = ([]);

#define ismerge(c) (sizeof( (c)["parent"] )>1)

void pp_commit(string id) {
   mapping c = commits[id];
   
   if (!options["guessff"] || !c )
      return;
      
   if (sizeof(c["parent"])==2) {
      string b0, b1;
      
      foreach (mergesub, string form)  
	 if (sscanf(c[""][1], form, b0, b1)==3)
            break;
      if (!b0 || !b1) {
         foreach (mmergesub, string form)  
            if (sscanf(c[""][1], form, b0)==2)
	       break;
	 b1 = "master";
      }

      if (b0 && b1) {
         if ((int)options["guessff"]>=2) {
	    c["Branch"] = (["$"+b0:0, "$"+b1:0]) + (c["Branch"]?c["Branch"]:([]));
	    commits[ c["parent"][0] ]["Branch"] = 
	        (["$"+b0:0, "$"+b1:0]) + (commits[ c["parent"][0] ]["Branch"]||([]));
	    extrabranches = (["$"+b0:0, "$"+b1:0]) + extrabranches;
	    
	    mapping bm = (["$"+b0:0])&c["Branch"];

	    if (sizeof(bm) && sizeof((["$"+b1:0])&c["Branch"])) {
	       commits[ c["parent"][0] ]["Branch"] -= bm;

	       if (!commits[ c["parent"][1] ])
        	  commits[ c["parent"][1] ] = ([ "Branch" : bm ]);
	       else
        	  commits[ c["parent"][1] ]["Branch"] += bm;
	    }
	 }
	 
         if (!c["Branch"])
	    return;
	    
	 mapping bm = ([b0:0])&c["Branch"];
	 
	 if (sizeof(bm) && sizeof(([b1:0])&c["Branch"])) {
	    if (options["verbose"])
               werror(" # Undoing FF @ %.12s %s\n", id, squeeze_subject(c[""][1]));
	       
	    commits[ c["parent"][0] ]["Branch"] -= bm;
	    
	    if (!commits[ c["parent"][1] ])
               commits[ c["parent"][1] ] = ([ "Branch" : bm ]);
	    else
               commits[ c["parent"][1] ]["Branch"] += bm;
	 }
      }
      else
         if (options["verbose"])
            werror(" # Unsupported merge subject %O\n", c[""][1]);
   }
}

array parsecommits(string ... delim) {
   array res = ({});
   string id;
   array lines = run("git", "rev-list", "--format=raw", "--ancestry-path",
                                        "--date-order", @delim)/"\n";
   foreach (lines, string line) {
      array words = line/" ";
      string h = words[0];
      if (h=="commit") {
         pp_commit(id);
	 
         id = words[1];
         if (!commits[id])
            commits[id] = ([]);
         res += ({id});
      } else if (h=="") {
         if (commits[id])
            commits[id][""] += ({line});
      }
      else {
         if (h=="parent") {
            string parent = words[1];
            if (!commits[parent])
	       commits[parent] = ([]);
	    if (!commits[id]["parent"]) // first parent?
	       if (commits[id]["Branch"]) {
	          if (!commits[parent]["Branch"])
		     commits[parent]["Branch"] = ([]);
        	  commits[parent]["Branch"] += commits[id]["Branch"];
	       }
	 }
         commits[id][h] += words[1..];
      }
   }
   pp_commit(id);
   return res;
}

static mapping desc = ([]);

static mapping branchnames = ([]);    // name : id
static mapping extrabranches = ([]);  // name : id

static mapping options = ([]);;
static array option_array = ({
   ({ "guessff", Getopt.MAY_HAVE_ARG, ({"-g"}) }),
   ({ "verbose", Getopt.MAY_HAVE_ARG, ({"-v", "--verbose"}) }),
});

int main(int argc, array argv) {
   array oa = Getopt.find_all_options(argv, option_array);
   foreach (oa, array a)
      options += ([a[0]:a[1]]);
   argv = Getopt.get_args(argv);
   argv[1] = (run("git", "rev-parse", argv[1])/"\n")[0];
   if (argc==2)
      argv += ({"master"});
   branchnames = git_refs(argv[2..]);
   if (sizeof(branchnames)==0)
      die("refs not found:%{ \"%s\"%}\n", "", argv[2..]);
   foreach (branchnames; string b; string id)
      if (commits[id])
         commits[id]["Branch"] += ([b:id]);
      else
         commits[id] = ([ "Branch" : ([b:id]) ]);
   array commit_list = parsecommits("^"+argv[1], @values(branchnames));
   commit_list += ({argv[1]});
   commit_list = reverse(commit_list);
   desc[argv[1]] = 1;
   foreach (commit_list, string id) {
      mapping c = commits[id];
      if (!c)
         continue;
      if (commits[id]["parent"]) {
         foreach (commits[id]["parent"], string parent)
            if (desc[parent])
                desc[id] = 1;
         if (ismerge(commits[id]))
            if (!desc[commits[id]["parent"][0]])
	       printidline(id);
      }
      mapping br = commits[id]["Branch"];
      if (br) {
         mapping reached = br&(branchnames|extrabranches);
         if (sizeof(reached)>0) {
	    array refs = Array.sort_array(indices(reached&branchnames));
	    if (sizeof(refs)) {
	       printidline(id);
               flush("          \\_ Appears in %s [%s]\n",
	               String.implode_nicely(refs), git_describe(id) );
	    }
            branchnames -= reached;
            if (sizeof(branchnames)==0)
               exit(0);
	    refs = Array.sort_array(indices(reached&extrabranches));
	    if (sizeof(refs)) {
	       printidline(id);
               flush("          \\_ Appears in %s [%s]\n",
	               String.implode_nicely(refs), git_describe(id) );
	    }
            extrabranches -= reached;
         }
      }
      m_delete(commits, id);
   }
   array refs = Array.sort_array(indices(branchnames));
   if (options["verbose"] || sizeof(refs)<10)
      write("             Not reachable from %s\n", String.implode_nicely(refs));
   else
      write("             Not reachable from %d refs (use -v option to show them all)\n",
               sizeof(refs));
}

static array outlines = ({});
static mapping shown = ([]);

void printidline(string id) {
  int comtime = commits[id]["committer"] && (int)commits[id]["committer"][-2];
  string subj = " ";
  if (shown[id])
     return;
  shown[id] = 1;
  if (commits[id][""])
     subj = commits[id][""][1];
  outlines += ({
     sprintf("%.12s %-54.54s %.12s\n", id,
         squeeze_subject(subj),
         comtime?cal->Second(comtime)->format_time_xshort():"")
      });
}
void flush(string fmt, string ... args) {
   write(outlines*"");
   write(fmt, @args);
   outlines = ({});
}

string git_describe(string id) {
   string res = (tryrun("git", "describe", id)/"\n")[0];
   if (res=="")
      res = (tryrun("git", "describe", "--tags", id)/"\n")[0];
   return res;
}

// Given glob pattern(s) ("m?st*r") return a mapping of
// all matching existing refs (symbolic:dereferenced_id)
mapping git_refs(array patterns) {
   mapping res = ([]);
   array tags = ({});

   foreach (patterns; int i; string pattern)
      if (pattern[0..4]!="refs/")
         patterns[i] = "*/"+pattern;
      
   foreach (run("git", "show-ref")/"\n", string line) {
      array words = line/" ";
      
      if (sizeof(words)<2)
         break;
      foreach (patterns, string pattern)
         if (glob(pattern, words[1]) || glob(pattern+"/*", words[1])) {
            if (words[1][0..9]!="refs/tags/")
               res += ([ words[1] : words[0] ]);
            else
               tags += ({words[1]});
            break;
         }
   }
   if (sizeof(tags)) {
      foreach (run("git", "show-ref", "-d", @tags)/"\n", string line) {
         if (line=="")
	    break;
         array words = line/" ";
         if (line[sizeof(line)-3..]=="^{}")
            res += ([ words[1][..sizeof(words[1])-4] : words[0] ]);
	 else // Could be a lightweight tag.
            if (!res[words[1]])
               res += ([ words[1] : words[0] ]);
      }
   }
   string prefix = String.common_prefix(indices(res));
   if (prefix!="") {
      int preflen = sizeof(prefix);
      while (preflen && prefix[preflen-1]!='/')
         preflen--;
      foreach (res; string in; string val)
         res[in[preflen..]] = m_delete(res, in);
   }
   return res;
}

string squeeze_subject(string subject) {
   subject = String.trim_all_whites(subject);
   subject = String.expand_tabs(subject);
   foreach (sub_from_to, mapping m)
      subject = replace(subject, m);
   return subject;
}

static array(mapping) sub_from_to =
({
   ([ 
      "Merge branch " : "Merge ",
      "Merge remote branch " : "Merge ",
      "Merge branches " : "MM:",
   ]),
   ([ 
      "Merge " : "M: ",
      "' of git:": "'@git:",
      "' into ": "' => ",
   ]),
   ([ 
       "git://git.kernel.org/pub/scm/linux/kernel/git/" : "$KO/",
       "master.kernel.org:/pub/scm/linux/kernel/git/" : "$KO/",
       "commit '" : "C'"
   ]),
});

static array mergesub =
({
   "%*[ ]Merge branch '%s' into %s",
   "%*[ ]Merge remote branch '%s' into %s",
   
   "%*[ ]Merge commit '%s' into %s",      // Hmm.
   "%*[ ]Merge tag '%s' into %s",         // Hmm^2.
   "%*[ ]Merge git://%s into %s",
   "%*[ ]Merge branch %s into %s",
});

static array mmergesub =
({
   "%*[ ]Merge branch '%s'",
   "%*[ ]Merge commit '%s'",              // Hmm.
   // project-specific
   "%*[ ]Merge git://git.kernel.org/pub/scm/linux/kernel/git/%s",
   // Scary? This is here for mostly historical reasons and really old merges:
   "%*[ ]Merge ssh://master.kernel.org/pub/scm/linux/kernel/git/%s",
   "%*[ ]Merge master.kernel.org:/pub/scm/linux/kernel/git/%s",
   "%*[ ]Merge master.kernel.org:/home/%s",
   "%*[ ]Merge with /pub/scm/linux/kernel/git/%s",
   "%*[ ]Merge with git+ssh://master.kernel.org/pub/scm/linux/kernel/git/%s",
   "%*[ ]Merge with ssh://master.kernel.org/pub/scm/linux/kernel/git/%s",
   "%*[ ]Merge with http://kernel.org/pub/scm/linux/kernel/git/%s",
   "%*[ ]Merge with rsync://rsync.kernel.org/pub/scm/linux/kernel/git/%s",
   "%*[ ]Merge of rsync://rsync.kernel.org/pub/scm/linux/kernel/git/%s",
   "%*[ ]Merge rsync://rsync.kernel.org/pub/scm/linux/kernel/git/%s",
   "%*[ ]Merge with master.kernel.org:/pub/scm/linux/kernel/git/%s",
   "%*[ ]Merge of master.kernel.org:/pub/scm/linux/kernel/git/%s",
   "%*[ ]Merge of master.kernel.org:/home/%s",
   "%*[ ]Automatic merge of rsync://rsync.kernel.org/pub/scm/linux/kernel/git/%s",
   "%*[ ]Automatic merge of master.kernel.org:/home/%s",
   "%*[ ]Automatic merge of master.kernel.org:/pub/scm/linux/kernel/git/%s",
   "%*[ ]Merge HEAD from master.kernel.org:/pub/scm/linux/kernel/git/%s",
   
   // Too generic? Comment them out and run with "-g -v" to look
   // for better candidates.
   "%*[ ]Merge git://%[^' ]",
   //"%*[ ]Merge %[^' ]",
});

string run(string ... cmdline) {
#if __REAL_MAJOR__<7 || __REAL_MAJOR__==7 && __REAL_MINOR__<8
   string s = Process.popen(cmdline*" ");
   if (s=="")
      die("\n", cmdline*" ");
   return s;
#else
   mapping r;
   mixed e = catch { r = Process.run( ({@cmdline}) ); };
   if (e || r["exitcode"])
      die("", e?e:r["stderr"]);
   return r["stdout"];
#endif
}

string tryrun(string ... cmdline) {
#if __REAL_MAJOR__<7 || __REAL_MAJOR__==7 && __REAL_MINOR__<8
   return Process.popen(cmdline*" " + " 2>/dev/null");
#else
   mapping r;
   mixed e = catch { r = Process.run( ({@cmdline}) ); };
   if (e || r["exitcode"])
      return "";
   return r["stdout"];
#endif
}

static object cal = Calendar.ISO.set_timezone(Calendar.Timezone.UTC);

---------------------------------------------------------------------------------
